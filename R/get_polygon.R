#' Get shapefiles from ABS
#'
#' @param name a character string containing absmapsdata file names in \code{[area][year]} format, eg "sa42016"; "gcc2021". See full list at https://github.com/wfmackey/absmapsdata. Note: if name is entered, then area and year values will be ignored.
#' @param area a character string containing the concise absmapsdata area names, eg "sa4"; "gcc". See full list at https://github.com/wfmackey/absmapsdata.
#' @param year a character string or numeric of the full source year of absmapsdata object, eg "2016"; 2021. See full list at https://github.com/wfmackey/absmapsdata.
#' @param remove_year_suffix logical defaulting to FALSE. If TRUE, 'strip_year_suffix' is run before returning the object, removing the '_year' suffix from variable names.
#' @param export_dir path to a directory to store the desired sf object. tempdir() by default.
#' @param .validate_name logical defaulting to TRUE, which checks the name input (or area year combination) against a list of available objects in the absmapsdata package.
#' @param simplify_keep proportion of points to retain (0-1; default 1 - no simplification).
#' @param ... arguments passed to \code{rmapshaper::ms_simplify()} (other than \code{keep}).
#'
#' @return a polygon of class \code{sf}.
#' @export
#'
#' @examples
#' get_polygon(area = "sa2", year = 2016)
#' get_polygon(name = "sa22016", simplify_keep = 0.05)
get_polygon <- function(name,
                        area,
                        year,
                        remove_year_suffix,
                        export_dir,
                        .validate_name,
                        simplify_keep = 1,
                        ...) {

  call <- match.call.defaults(expand.dots = FALSE)
  call[[1]] <- as.name("check_for_internal_polygon")
  polygon <- eval(call, envir = parent.frame())

  if(is.null(polygon)) {
    # call strayr::read_absmap with all args except for `simplify_keep`
    call <- match.call.defaults(expand.dots = FALSE)
    call$simplify_keep <- NULL
    call$... <- NULL
    call[[1]] <- as.name("read_absmap")

    polygon <- evaluate::try_capture_stack(
      eval(call, envir = parent.frame()),
      env = parent.frame()
    )

    if(evaluate::is.error(polygon)) {
      if(stringr::str_detect(polygon$message, "Applicable files are:")) {
        stop(glue::glue(
          "Error when running '{capture.output(polygon$call)}'\n",
          "{polygon$message}, ",
          "{paste0(.get_internal_polygon_names(), collapse = ', ')}
"
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

  polygon
}

#' @importFrom strayr read_absmap
#' @export
strayr::read_absmap


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
  if (any(c(name, area) %in% c("QLDLHN", "HHS"))) {
    message("The data for The Hospital and Health Service boundaries (QLD) are from here: <https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid={A4661F6D-0013-46EE-A446-A45F01A64D46}>")
    return(qld_hhs)
  }

  if (any(c(name, area) %in% c("NSWLHN", "LHD"))) {
    message("The data for The Local Health Districts boundaries (NSW) are from here: <https://github.com/wfmackey/absmapsdata/raw/master/data/nsw_lhd2023.rda>")
    return(read_absmap("nsw_lhd2023"))
  }

  if (any(c(name, area) %in% c("SALHN"))) {
    message("The data for The Local Hospital Network boundaries (SA) are from here: <https://data.gov.au/dataset/ds-sa-120bdc9e-1c96-4ea5-b98c-aa148bb33a10/details?q=primary%20health%20network>")
    return(sa_lhn)
  }

  if (any(c(name, area) %in% c("PHN"))) {
    message("The data for The Primary Health Network (PHN) are from here: <https://data.gov.au/dataset/ds-dga-ef2d28a4-1ed5-47d0-8e3a-46e25bc4f66b/details?q=primary%20health%20network>")
    return(phn)
  }
}

.get_internal_polygon_names <- function() {
  c(
    "QLDLHN",
    "HHS",
    "SALHN",
    "PHN"
  )
}
