#' Download ASGS shape files via \code{ASGS.foyer}.
#'
#' @param ... Args passed to \code{ASGS.foyer::install_ASGS()}
#'
#' @return \code{NULL}
#' @export
#'
#' @examples
#' \donttest{
#' # download_shapefiles()
#' }
download_shapefiles <- function(...) {

  withr::with_options(
    list(timeout = 300),
    ASGS.foyer::install_ASGS(url.tar.gz = "https://github.com/HughParsonage/ASGS/archive/refs/tags/v2021.0.tar.gz")
  )

  # url <- "https://github.com/HughParsonage/ASGS/archive/refs/tags/v2021.0.zip"
  # tempf <- tempfile(fileext = ".zip", tmpdir = ".")
  # withr::with_options(
  #   list(timeout = 300),
  #   utils::download.file(
  #     url = url,
  #     destfile = "./file6971730e70bdb.zip"
  #   )
  # )
  # unzip("asgs_source.zip")
  # devtools::install("ASGS-2021.0")
}
