#' Read a dataset from <github.com/healthpolicyanalysis/hpa.spatial.data/>
#'
#' @param name The name of dataset in \code{hpa.spatial.data} repo.
#' Valid names are those within \code{get_data_file_list()}.
#' @param export_dir The directory to store the downloaded data.
#'
#' @return An \code{sf} object.
#' @export
#'
#' @examples
#' read_hpa_spatial_data("lhn")
read_hpa_spatial_data <- function(name, export_dir = tempdir()) {
  assertthat::assert_that(assertthat::is.scalar(name))
  # adapted from strayr::read_absmap()
  assertthat::assert_that(assertthat::is.writeable(export_dir))

  base_url <- "https://github.com/healthpolicyanalysis/hpa.spatial.data/raw/fcdd8ccc7f87ba3a48f527180c84db4ea6a21ad4/data/"
  out_path <- file.path(export_dir, paste0(name, ".rda"))

  if (!file.exists(out_path)) {
    file_list <- stop_on_error(
      get_data_file_list(),
      "Error reading the file list from hpa.spatial.data github repo. Check that you have access to the internet."
    )

    assertthat::assert_that(name %in% file_list)

    split_files <- get_split_files()
    if (name %in% names(split_files)) {
      name_download <- split_files[[name]]
      urls <- paste0(base_url, name_download, ".rda")
      out_paths <- file.path(export_dir, paste0(name_download, ".rda"))

      # download all sub-datasets
      for (i in 1:length(name_download)) {
        download_data(url = urls[i], dest = out_paths[i])
      }

      eval(
        rlang::expr(
          !!rlang::sym(name) <- purrr::map2(name_download, out_paths, function(name, path) {
            load(path)
            get(name)
          }) |>
            dplyr::bind_rows()
        )
      )

      # save as combined dataset at original out_path
      eval(rlang::expr(save(!!rlang::sym(name), file = out_path)))
      eval(rlang::expr(return(!!rlang::sym(name))))
    } else {
      url <- paste0(base_url, name, ".rda")
      download_data(url = paste0(base_url, name, ".rda"), dest = out_path)

      load(out_path)
      return(get(name))
    }
  } else {
    load(out_path)
    return(get(name))
  }
}


get_data_file_list <- function() {
  c(
    "acpr",
    "lhn",
    "phn",
    "mb21_poly",
    "mb21_pop",
    "mmm19",
    "mmm23"
  )
}


get_split_files <- function() {
  list(
    "mb21_poly" = c("mb21_poly_A", "mb21_poly_B")
  )
}


download_data <- function(url, dest) {
  stop_on_error(
    utils::download.file(url, destfile = dest, mode = "wb"),
    glue::glue(
      "Download failed. Check that you have access to the internet and that ",
      "your requested object is one of the following:",
      "{paste0(get_data_file_list(), collapse = '\n')}"
    )
  )
}


stop_on_error <- function(expr, msg) {
  tryCatch(expr, error = function(e) stop(msg, call. = FALSE))
}
