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
  # call strayr::read_absmap with all args except for `simplify_keep`
  call <- match.call.defaults(expand.dots = FALSE)
  call$simplify_keep <- NULL
  call$... <- NULL
  call[[1]] <- as.name("read_absmap")
  polygon <- eval(call, envir = parent.frame())

  # apply smoothing to polygon
  if (simplify_keep != 1) {
    polygon <- rmapshaper::ms_simplify(polygon, keep = simplify_keep, ...)
  }

  polygon
}

#' @importFrom strayr read_absmap
#' @export
strayr::read_absmap

match.call.defaults <- function(definition = sys.function(sys.parent()),
                                call = sys.call(sys.parent()),
                                expand.dots = TRUE,
                                envir = parent.frame(2L)) {
  # https://rdrr.io/cran/stackoverflow/src/R/match.call.default.R
  call <- match.call(definition, call, expand.dots, envir)
  formals <- formals(definition)

  if (expand.dots && "..." %in% names(formals)) {
    formals[["..."]] <- NULL
  }

  for (i in setdiff(names(formals), names(call))) {
    call[i] <- list(formals[[i]])
  }


  match.call(definition, call, TRUE, envir)
}
