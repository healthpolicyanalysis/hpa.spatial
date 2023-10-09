#' get a correspondence table, either via \code{strayr::read_correspondence_tbl}
#' or by creating one with \code{make_correspondence_tbl}.
#'
#' @param from_area The area you want to correspond FROM (ie the areas your data
#' are currently in). For example: "sa1", "sa2, "sa3", "sa4".
#' @param from_year The year you want to correspond FROM. For example: 2011,
#' 2016.
#' @param from_geo The FROM polygon geography. Helpful if it is not available
#' using \code{from_year} and \code{from_area} in \code{get_polygon}.
#' @param to_area The area you want to correspond TO (ie the areas you want your
#' data to be in).
#' @param to_year The year you want to correspond TO.
#' @param to_geo The TO polygon geography. Helpful if it is not available
#' using \code{to_year} and \code{to_area} in \code{get_polygon}.
#' @param export_dir The directory to store the downloaded data.
#' @param export_fname The file name for the saved file (applicable if
#' \code{from_geo}) and \code{to_geo} are used instead of areas and years).
#' @param mb_geo mesh blocks data with census population. Defaults to using the
#' 2021 edition mesh blocks and 2021 census data (see
#' \code{get_mb21_pop()}).
#'
#' @return a \code{tibble}.
#' @export
#'
#' @examples
#' get_correspondence_tbl(from_area = "sa2", from_year = 2021, to_area = "LHN")
get_correspondence_tbl <- function(from_area = NULL,
                                   from_year = NULL,
                                   from_geo = NULL,
                                   to_area = NULL,
                                   to_year = NULL,
                                   to_geo = NULL,
                                   export_dir = tempdir(),
                                   export_fname = NULL,
                                   mb_geo = get_mb21_pop()) {
  if (!dir.exists(export_dir)) {
    stop("export_dir provided does not exist: ", export_dir)
  }

  if (is.null(export_fname)) {
    assertthat::assert_that(
      !all(is.null(c(from_area, from_year))),
      msg = paste(
        "'from_area' and 'from_year' are both NULL. If a geometry is being",
        "passed with 'from_geo', pass a that represents the desired",
        "correspondence table using 'export_fname'.",
        sep = "\n"
      )
    )
    assertthat::assert_that(
      !all(is.null(c(to_area, to_year))),
      msg = paste(
        "'to_area' and 'to_year' are both NULL. If a geometry is being",
        "passed with 'to_geo', pass a that represents the desired",
        "correspondence table using 'export_fname'.",
        sep = "\n"
      )
    )

    export_fname <- make_fname(
      from_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_area))),
      from_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_year))),
      to_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_area))),
      to_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_year)))
    )
  }

  out_path <- file.path(export_dir, export_fname)

  if (file.exists(out_path)) {
    return(readRDS(out_path))
  }


  call <- rlang::expr(strayr::read_correspondence_tbl(
    from_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_area))),
    from_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_year))),
    to_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_area))),
    to_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_year))),
    export_dir = rlang::eval_tidy(rlang::expr(!!rlang::quo(export_dir)))
  ))

  cg <- try(suppressMessages(suppressWarnings(rlang::eval_tidy(call))), silent = TRUE)


  if (inherits(cg, "try-error")) { # not a correspondence table accessible via strayr...
    message("Failed to retrieve correspondence table through {strayr}, making correspondence table")

    crs <- sf::st_crs(mb_geo)$input

    if (is.null(from_geo)) {
      from_geo <- get_polygon(area = from_area, year = from_year, crs = crs)
    } else {
      from_geo <- update_crs(from_geo, crs = crs)
    }

    if (is.null(to_geo)) {
      to_geo <- get_polygon(area = to_area, year = to_year, crs = crs)
    } else {
      to_geo <- update_crs(to_geo, crs = crs)
    }

    cg <- make_correspondence_tbl(
      from_geo = from_geo,
      to_geo = to_geo,
      mb_geo = mb_geo
    )
  } else {
    cg <- cg |>
      dplyr::select(1, 3, ratio) |>
      dplyr::mutate(dplyr::across(1:2, as.character))
  }

  saveRDS(cg, file = out_path)
  cg
}


make_fname <- function(from_area = NULL,
                       from_year = NULL,
                       to_area = NULL,
                       to_year = NULL) {
  name <- "CG"
  if (!is.null(from_area)) {
    name <- paste0(name, "_from_area_", from_area)
  }
  if (!is.null(from_year)) {
    name <- paste0(name, "_from_year_", from_year)
  }
  if (!is.null(to_area)) {
    name <- paste0(name, "_to_area_", to_area)
  }
  if (!is.null(to_year)) {
    name <- paste0(name, "_to_year_", to_year)
  }
  paste0(name, ".rds")
}
