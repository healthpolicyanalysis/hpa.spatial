#' get a correspondence table, either via \code{strayr::read_correspondence_tbl}
#' or by creating one with \code{make_correspondence_tbl}.
#'
#' @param from_area The area you want to correspond FROM (ie the areas your data
#' are currently in). For example: "sa1", "sa2, "sa3", "sa4".
#' @param from_year The year you want to correspond FROM. For example: 2011,
#' 2016.
#' @param to_area The area you want to correspond TO (ie the areas you want your
#' data to be in).
#' @param to_year The year you want to correspond TO.
#' @param export_dir The directory to store the downloaded data.
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
                                   to_area = NULL,
                                   to_year = NULL,
                                   export_dir = tempdir(),
                                   mb_geo = get_mb21_pop()) {
  if (!dir.exists(export_dir)) {
    stop("export_dir provided does not exist: ", export_dir)
  }

  fname <- make_fname(
    from_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_area))),
    from_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_year))),
    to_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_area))),
    to_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_year)))
  )

  out_path <- file.path(export_dir, fname)

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


    from_polygon <- get_polygon(area = from_area, year = from_year, crs = 7844)
    to_polygon <- get_polygon(area = to_area, year = to_year, crs = 7844)

    cg <- make_correspondence_tbl(from_geo = from_polygon, to_geo = to_polygon, mb_geo = mb_geo)
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
