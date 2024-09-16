#' Get shapefiles from ABS (via \code{strayr} and \code{absmapsdata} or via
#' \code{hpa.spatial} and \code{hpa.spatial.data})
#'
#' @param name A character string containing \code{absmapsdata} file names in
#' \code{[area][year]} format, eg "sa42016"; "gcc2021". See full list at
#' <https://github.com/wfmackey/absmapsdata>. Note: if name is entered, then
#' area and year values will be ignored.
#' @param area A character string containing the concise absmapsdata area names,
#' eg "sa4"; "gcc". See full list at <https://github.com/wfmackey/absmapsdata>.
#' @param year A character string or numeric of the full source year of
#' \code{absmapsdata} object, eg "2016"; 2021. See full list at
#' <https://github.com/wfmackey/absmapsdata>.
#' @param remove_year_suffix A logical defaulting to FALSE. If TRUE,
#' 'strip_year_suffix' is run before returning the object, removing the '_year'
#' suffix from variable names.
#' @param export_dir Path to a directory to store the desired sf object.
#' \code{tempdir()} by default.
#' @param .validate_name Logical defaulting to TRUE, which checks the name
#' input (or area year combination) against a list of available objects in the
#' \code{absmapsdata} package.
#' @param simplify_keep The proportion of points to retain (0-1; default 1 -
#' no simplification).
#' @param crs Whether to update the crs (if necessary) of the returned polygon.
#' @param quiet whether to be quiet about warnings and messages. Set package
#' level quiet-ness with \code{options(hpa.spatial.quiet = TRUE)}.
#' @param ... Arguments passed to \code{rmapshaper::ms_simplify()} (other than
#' \code{keep}).
#'
#' @return A polygon of class \code{sf}.
#' @export
#'
#' @examples
#' get_polygon(area = "sa2", year = 2016)
#' get_polygon(name = "sa22016", simplify_keep = 0.05)
get_polygon <- function(name = NULL,
                        area = NULL,
                        year = NULL,
                        remove_year_suffix,
                        export_dir = tempdir(),
                        .validate_name,
                        simplify_keep = 1,
                        crs = NULL,
                        quiet = getOption("hpa.spatial.quiet", FALSE),
                        ...) {
  call <- rlang::expr(check_for_internal_polygon(
    name = rlang::eval_tidy(rlang::expr(!!rlang::quo(name))),
    area = rlang::eval_tidy(rlang::expr(!!rlang::quo(area))),
    year = rlang::eval_tidy(rlang::expr(!!rlang::quo(year))),
    export_dir = rlang::eval_tidy(rlang::expr(!!rlang::quo(export_dir))),
    quiet = quiet
  ))

  polygon <- rlang::eval_tidy(call)

  if (is.null(polygon)) {
    call <- rlang::expr(
      strayr::read_absmap(
        name = rlang::eval_tidy(rlang::expr(!!rlang::quo(name))),
        area = rlang::eval_tidy(rlang::expr(!!rlang::quo(area))),
        year = rlang::eval_tidy(rlang::expr(!!rlang::quo(year))),
        export_dir = rlang::eval_tidy(rlang::expr(!!rlang::quo(export_dir)))
      )
    )

    if (quiet) {
      f <- function(x) suppressMessages(suppressWarnings(x))
    } else {
      f <- function(x) x
    }
    polygon <- f(evaluate::try_capture_stack(
      rlang::eval_tidy(call),
      env = rlang::current_env()
    ))

    if (evaluate::is.error(polygon)) {
      if (stringr::str_detect(polygon$message, "Applicable files are:")) {
        stop(glue::glue(
          "Error when running '{capture.output(polygon$call)}'\n",
          "{polygon$message}, ",
          "{paste0(.get_internal_polygon_names(), collapse = ', ')}"
        ))
      } else {
        stop(print(polygon))
      }
    }
  }

  # apply smoothing to polygon
  if (simplify_keep != 1) {
    polygon <- rmapshaper::ms_simplify(polygon, keep = simplify_keep, ...)
  }

  update_crs(polygon, crs = crs)
}


update_crs <- function(geo, crs = NULL) {
  if (!is.null(crs)) {
    if (crs == "GDA2020") {
      crs <- 7844
    }
    if (sf::st_crs(crs)$input != sf::st_crs(geo)$input) {
      geo <- sf::st_transform(geo, crs)
    }
  }
  geo
}


#' Check for (and return if so) the shape if it is "internal" (contained within
#' \code{hpa.spatial}/\code{hpa.spatial.data})
#'
#' @param name A character string names to identify data not kept on
#' \code{absmapsdata}.
#' @param area A character string names to identify data not kept on
#' \code{absmapsdata}.
#' @param year A character string names to identify data not kept on
#' \code{absmapsdata}.
#' @param export_dir The directory to store the downloaded data.
#' @param quiet whether to be quiet about warnings and messages. Set package
#' level quiet-ness with \code{options(hpa.spatial.quiet = TRUE)}.
#' @param ... Additional, ignored arguments.
#'
#' @return An \code{sf} object or, if no pkg data found, \code{NULL}.
#' @export
#'
#' @examples
#' # Get the Local Hospital Network (LHN) shapes.
#' shp <- check_for_internal_polygon(name = "LHN")
check_for_internal_polygon <- function(name = NULL,
                                       area = NULL,
                                       year = NULL,
                                       export_dir = tempdir(),
                                       quiet = getOption("hpa.spatial.quiet", FALSE),
                                       ...) {
  if (any(c(toupper(name), toupper(area)) %in% c("ACPR"))) {
    .q_message(quiet = quiet, "The data for the Aged Care Planning Regions in Australia (2018 edition) are from here: <https://www.gen-agedcaredata.gov.au/resources/access-data/2020/january/aged-care-planning-region-maps>")
    return(read_hpa_spatial_data("acpr", export_dir = export_dir))
  }
  if (any(c(toupper(name), toupper(area)) %in% c("PHN"))) {
    .q_message(quiet = quiet, "The data for The Primary Health Network (PHN) are from here: <https://data.gov.au/dataset/ds-dga-ef2d28a4-1ed5-47d0-8e3a-46e25bc4f66b/details?q=primary%20health%20network>")
    return(read_hpa_spatial_data("phn", export_dir = export_dir))
  }

  if (any(c(toupper(name), toupper(area)) %in% c("LHN"))) {
    .q_message(quiet = quiet, "The data for the Local Hospital Networks (LHN) are from here: <https://hub.arcgis.com/datasets/ACSQHC::local-hospital-networks/explore>")
    return(read_hpa_spatial_data("lhn", export_dir = export_dir))
  }

  if (any(c(toupper(name), toupper(area)) %in% c("MB21"))) {
    return(get_mb21_poly(export_dir = export_dir))
  }

  if (any(c(toupper(name), toupper(area)) %in% c("MMM19"))) {
    return(get_mmm19_poly(export_dir = export_dir))
  }
}

#' Get Mesh Blocks (2021 edition) and population counts
#'
#' @param export_dir The directory to store the downloaded data.
#'
#' @return An \code{sf} object.
#' @export
#'
#' @examples
#' get_mb21_pop()
get_mb21_pop <- function(export_dir = tempdir()) {
  read_hpa_spatial_data("mb21_pop", export_dir = export_dir)
}

#' Get Mesh Blocks (2021 edition) polygons
#'
#' @param export_dir The directory to store the downloaded data.
#'
#' @return A \code{sf} object.
#' @export
#'
#' @examples
#' get_mb21_poly()
get_mb21_poly <- function(export_dir = tempdir()) {
  read_hpa_spatial_data("mb21_poly", export_dir = export_dir)
}


#' Modified Monash Model polygons (SA1, 2016 edition, polygons with MMM, 2019
#' edition column)
#'
#' @param export_dir The directory to store the downloaded data.
#'
#' @return An \code{sf} object.
#' @export
#'
#' @examples
#' get_mmm19_poly()
get_mmm19_poly <- function(export_dir = tempdir()) {
  sa1_poly <- get_polygon("sa12016", export_dir = export_dir)
  mmm19 <- read_hpa_spatial_data("mmm19", export_dir = export_dir)
  names(sa1_poly)[1] <- names(mmm19)[1]
  sa1_poly[[1]] <- as.numeric(sa1_poly[[1]])
  mmm19[[1]] <- as.numeric(mmm19[[1]])

  dplyr::inner_join(
    sa1_poly,
    mmm19,
    by = names(mmm19)[1]
  )
}


.get_internal_polygon_names <- function() {
  c(
    "ACPR",
    "PHN",
    "LHN",
    "MB21",
    "MMM19"
  )
}


.q_message <- function(..., quiet = getOption("hpa.spatial.quiet", FALSE)) {
  if (!quiet) {
    message(...)
  }
}
