#' Estimate drive times/distances for specific origin-destination pairs
#'
#' A wrapper around \code{osrm::osrmTable()} for when only specific
#' origin-destination pairs are needed, rather than the full matrix of
#' travel times/distances between every combination of points. Rather than
#' sending every unique origin and every unique destination to a single
#' \code{osrm::osrmTable()} call (which would request the full cross-product
#' between them), pairs are grouped by whichever of \code{origins} or
#' \code{destinations} has fewer unique points, and one \code{osrm::osrmTable()}
#' call is made per group, scoped only to the counterpart points actually
#' paired with it. This keeps each request small and avoids hitting a
#' server's max-table-size limit when there are many distinct pairs, at the
#' cost of issuing more requests than a single full-matrix call.
#'
#' @param origins Origin points, one row per pair, as an sf or sfc object of
#' type POINT. If relevant, row names are used as identifiers.
#' @param destinations Destination points, one row per pair, matching
#' \code{origins} row for row, as an sf or sfc object of type POINT with the
#' same CRS as \code{origins}.
#' @param exclude Passed to \code{osrm::osrmTable()}: an optional "exclude"
#' request option for the OSRM API (not allowed with the OSRM demo server).
#' @param measure A character indicating what measures are calculated. It
#' can be "duration" (in minutes), "distance" (in meters), or both
#' \code{c("duration", "distance")}.
#' @param osrm.server The base URL of the routing server.
#' @param osrm.profile The routing profile to use, e.g. "car", "bike" or
#' "foot".
#'
#' @return A \code{tibble} with one row per origin-destination pair,
#' including the origin and destination coordinates and ids, and the
#' requested \code{duration} (in minutes) and/or \code{distance} (in
#' meters) columns. If a request for a group of pairs fails twice (the
#' original attempt plus one retry), those pairs are returned with
#' \code{NA} duration/distance rather than aborting the whole call, and a
#' warning reports how many pairs failed.
#' @export
#'
#' @examples
#' \dontrun{
#' origins <- sf::st_as_sf(
#'   data.frame(lon = c(13.38, 13.40), lat = c(52.52, 52.50)),
#'   coords = c("lon", "lat"), crs = 4326
#' )
#' destinations <- sf::st_as_sf(
#'   data.frame(lon = c(13.41, 13.39), lat = c(52.53, 52.51)),
#'   coords = c("lon", "lat"), crs = 4326
#' )
#' osrm_table_pairs(origins, destinations)
#' }
osrm_table_pairs <- function(
  origins,
  destinations,
  exclude,
  measure = "duration",
  osrm.server = getOption("osrm.server", "https://routing.openstreetmap.de/"),
  osrm.profile = getOption("osrm.profile", "car")
) {
  assertthat::assert_that(
    inherits(origins, c("sf", "sfc")),
    msg = "`origins` must be an sf or sfc object."
  )
  assertthat::assert_that(
    inherits(destinations, c("sf", "sfc")),
    msg = "`destinations` must be an sf or sfc object."
  )
  assertthat::assert_that(
    sf::st_crs(origins) == sf::st_crs(destinations),
    msg = "`origins` and `destinations` must have the same CRS."
  )

  origin_coords <- .osrm_pair_coords(origins, "origins")
  destination_coords <- .osrm_pair_coords(destinations, "destinations")

  assertthat::assert_that(
    nrow(origin_coords) == nrow(destination_coords),
    msg = "`origins` and `destinations` must have the same number of rows."
  )

  origin_key <- paste(origin_coords$lon, origin_coords$lat)
  destination_key <- paste(destination_coords$lon, destination_coords$lat)

  out <- tibble::tibble(
    origin_id = origin_coords$id,
    origin_lon = origin_coords$lon,
    origin_lat = origin_coords$lat,
    destination_id = destination_coords$id,
    destination_lon = destination_coords$lon,
    destination_lat = destination_coords$lat
  )
  if ("duration" %in% measure) {
    out$duration <- NA_real_
  }
  if ("distance" %in% measure) {
    out$distance <- NA_real_
  }

  # Group by whichever side has fewer unique points, so we issue the fewest
  # osrmTable() calls while keeping each call's grid scoped to only the
  # counterpart points actually paired with that group.
  group_by_origin <- length(unique(origin_key)) <=
    length(unique(destination_key))

  if (group_by_origin) {
    group_key <- origin_key
  } else {
    group_key <- destination_key
  }

  table_args_base <- list(
    measure = measure,
    osrm.server = osrm.server,
    osrm.profile = osrm.profile
  )

  if (!missing(exclude)) {
    table_args_base$exclude <- exclude
  }

  keys <- unique(group_key)
  n_failed_pairs <- 0L
  last_error_msg <- NULL

  cli::cli_progress_bar(
    name = paste("Requesting", paste(measure, collapse = "/")),
    total = length(keys)
  )

  for (key in keys) {
    idx <- which(group_key == key)

    if (group_by_origin) {
      counterpart_key <- destination_key[idx]
      unique_idx <- idx[!duplicated(counterpart_key)]
      src <- origin_coords[idx[1], c("lon", "lat")]
      dst <- destination_coords[unique_idx, c("lon", "lat")]
      cell <- cbind(1, match(counterpart_key, destination_key[unique_idx]))
    } else {
      counterpart_key <- origin_key[idx]
      unique_idx <- idx[!duplicated(counterpart_key)]
      src <- origin_coords[unique_idx, c("lon", "lat")]
      dst <- destination_coords[idx[1], c("lon", "lat")]
      cell <- cbind(match(counterpart_key, origin_key[unique_idx]), 1)
    }

    result <- .osrm_table_with_retry(c(list(src = src, dst = dst), table_args_base))

    if (inherits(result, "error")) {
      n_failed_pairs <- n_failed_pairs + length(idx)
      last_error_msg <- conditionMessage(result)
    } else {
      if ("duration" %in% measure) {
        out$duration[idx] <- result$durations[cell]
      }
      if ("distance" %in% measure) {
        out$distance[idx] <- result$distances[cell]
      }
    }

    cli::cli_progress_update()
  }

  cli::cli_progress_done()

  if (n_failed_pairs > 0) {
    warning(
      glue::glue(
        "{n_failed_pairs} of {nrow(out)} origin-destination pair(s) failed ",
        "after retrying and were returned as NA.\n",
        "Last error: {last_error_msg}",
        "{.osrm_table_ssl_hint(last_error_msg)}"
      ),
      call. = FALSE
    )
  }

  out
}


#' Call \code{osrm::osrmTable()}, retrying once on error
#'
#' @param table_args A list of arguments to pass to \code{osrm::osrmTable()}.
#'
#' @return The result of \code{osrm::osrmTable()}, or the \code{error}
#' condition raised if it fails on both the original attempt and the retry.
#' @keywords internal
.osrm_table_with_retry <- function(table_args) {
  attempt <- function() {
    tryCatch(do.call(osrm::osrmTable, table_args), error = function(e) e)
  }

  result <- attempt()
  if (inherits(result, "error")) {
    result <- attempt()
  }
  result
}


#' Build a hint for the known Windows curl/SSL backend issue, if relevant
#'
#' @param msg The error message from a failed \code{osrm::osrmTable()} call.
#'
#' @return A character string (possibly empty) to append to a warning
#' message.
#' @keywords internal
.osrm_table_ssl_hint <- function(msg) {
  if (is.null(msg) || !grepl("ssl|certificate|schannel", msg, ignore.case = TRUE)) {
    return("")
  }
  glue::glue(
    "\n\nThis looks like a curl/SSL backend issue, which is common on ",
    "Windows when the default backend cannot validate the server's ",
    "certificate. Try switching curl to the OpenSSL backend before ",
    "retrying:\n\n",
    "  Sys.setenv(CURL_SSL_BACKEND = \"openssl\")\n\n",
    "or set `CURL_SSL_BACKEND=openssl` in your `.Renviron` so it ",
    "applies to every R session."
  )
}

#' Extract lon/lat coordinates (and row ids) from an sf/sfc POINT input
#'
#' @param x An sf or sfc object of type POINT.
#' @param arg_name The name of the argument being checked, used in error
#' messages.
#'
#' @return A \code{tibble} with \code{id}, \code{lon} and \code{lat} columns.
#' @keywords internal
.osrm_pair_coords <- function(x, arg_name) {
  geom <- sf::st_geometry(x)
  geom_type <- unique(as.character(sf::st_geometry_type(geom)))
  assertthat::assert_that(
    length(geom_type) == 1 && geom_type == "POINT",
    msg = glue::glue("`{arg_name}` geometry must be of type POINT.")
  )
  geom <- sf::st_transform(geom, 4326)
  coords <- sf::st_coordinates(geom)
  ids <- if (inherits(x, "sf")) row.names(x) else as.character(seq_along(geom))

  tibble::tibble(id = ids, lon = coords[, 1], lat = coords[, 2])
}
