#' Get shapefiles from ABS
#'
#' @param name a character string containing absmapsdata file names in \code{[area][year]} format, eg "sa42016"; "gcc2021". See full list at https://github.com/wfmackey/absmapsdata. Note: if name is entered, then area and year values will be ignored.
#' @param area a character string containing the concise absmapsdata area names, eg "sa4"; "gcc". See full list at https://github.com/wfmackey/absmapsdata.
#' @param year a character string or numeric of the full source year of absmapsdata object, eg "2016"; 2021. See full list at https://github.com/wfmackey/absmapsdata.
#' @param remove_year_suffix logical defaulting to FALSE. If TRUE, 'strip_year_suffix' is run before returning the object, removing the '_year' suffix from variable names.
#' @param export_dir path to a directory to store the desired sf object. tempdir() by default.
#' @param .validate_name logical defaulting to TRUE, which checks the name input (or area year combination) against a list of available objects in the absmapsdata package.
#' @param simplify_keep proportion of points to retain (0-1; default 1 - no simplification).
#' @param crs whether to update the crs (if necessary) of the returned polygon.
#' @param ... arguments passed to \code{rmapshaper::ms_simplify()} (other than \code{keep}).
#'
#' @return a polygon of class \code{sf}.
#' @export
#'
#' @examples
#' get_polygon(area = "sa2", year = 2016)
#' get_polygon(name = "sa22016", simplify_keep = 0.05)
get_polygon <- function(name = NULL,
                        area = NULL,
                        year = NULL,
                        remove_year_suffix,
                        export_dir,
                        .validate_name,
                        simplify_keep = 1,
                        crs = NULL,
                        ...) {
  call <- rlang::expr(check_for_internal_polygon(
    name = rlang::eval_tidy(rlang::expr(!!rlang::quo(name))),
    area = rlang::eval_tidy(rlang::expr(!!rlang::quo(area))),
    year = rlang::eval_tidy(rlang::expr(!!rlang::quo(year)))
  ))

  polygon <- rlang::eval_tidy(call)

  if (is.null(polygon)) {
    call <- rlang::expr(
      strayr::read_absmap(
        name = rlang::eval_tidy(rlang::expr(!!rlang::quo(name))),
        area = rlang::eval_tidy(rlang::expr(!!rlang::quo(area))),
        year = rlang::eval_tidy(rlang::expr(!!rlang::quo(year)))
      )
    )

    polygon <- evaluate::try_capture_stack(
      rlang::eval_tidy(call),
      env = rlang::current_env()
    )

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
    if(sf::st_crs(crs)$input != sf::st_crs(geo)$input) {
      geo <- sf::st_transform(geo, crs)
    }
  }
  geo
}


#' check_for_internal_polygon
#'
#' @param name a character string names to identify data not kept on absmapsdata.
#' @param area a character string names to identify data not kept on absmapsdata.
#' @param year a character string names to identify data not kept on absmapsdata.
#' @param ... additional, ignored arguments.
#'
#' @return a \code{sf} object or, if no pkg data found, \code{NULL}.
#' @export
#'
#' @examples
#' # hospital and health services (HHS) is the name for the local hospital networks in QLD.
#' shp <- check_for_internal_polygon(name = "HHS")
check_for_internal_polygon <- function(name = NULL, area = NULL, year = NULL, ...) {
  # use non-null arg (of name/area) to identify LHN data
  if (any(c(name, area) %in% c("PHN"))) {
    message("The data for The Primary Health Network (PHN) are from here: <https://data.gov.au/dataset/ds-dga-ef2d28a4-1ed5-47d0-8e3a-46e25bc4f66b/details?q=primary%20health%20network>")
    return(phn)
  }

  if (any(c(name, area) %in% c("LHN"))) {
    message("The data for the Local Hospital Networks (LHN) are from here: <https://hub.arcgis.com/datasets/ACSQHC::local-hospital-networks/explore>")
    return(lhn)
  }
}

.get_internal_polygon_names <- function() {
  c(
    "PHN",
    "LHN"
  )
}
