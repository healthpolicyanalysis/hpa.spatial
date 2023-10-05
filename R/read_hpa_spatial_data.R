read_hpa_spatial_data <- function(name, export_dir = tempdir()) {
  # adapted from strayr::read_absmap()

  if (!dir.exists(export_dir)) {
    stop("export_dir provided does not exist: ", export_dir)
  }

  base_url <- "https://github.com/healthpolicyanalysis/hpa.spatial.data/raw/main/data/"
  out_path <- file.path(export_dir, paste0(name, ".rda"))

  if (!file.exists(out_path)) {
    file_list <- tryCatch(
      get_data_file_list(),
      error = "Error reading the file list from hpa.spatial.data github repo. Check that you have access to the internet."
    )

    assertthat::assert_that(name %in% get_data_file_list())

    if (name %in% names(get_split_files())) {
      name_download <- get_split_files()[[name]]
      urls <- paste0(base_url, name_download, ".rda")
      out_paths <- file.path(export_dir, paste0(name_download, ".rda"))

      # download all sub-datasets
      for (i in 1:length(name_download)) {
        download_data(url = urls[i], dest = out_paths[i])
      }

      # read and combine the datasets
      paste0(name, "<- purrr::map2(name_download, out_paths, function(name, path) {",
        "load(path);",
        "get(name)",
      "}) |>",
        "dplyr::bind_rows()") |>
        (\(x) parse(text = x))() |>
        eval()

      # save as combined dataset at original out_path
      eval(parse(text = glue::glue("save({name}, file = out_path)")))
      eval(parse(text = glue::glue("return({name})")))
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
  req <- httr::GET("https://api.github.com/repos/healthpolicyanalysis/hpa.spatial.data/git/trees/main?recursive=1")
  httr::stop_for_status(req)
  filelist <- unlist(lapply(httr::content(req)$tree, "[", "path"), use.names = F)

  stringr::str_subset(filelist, "data/") |>
    stringr::str_remove("data/") |>
    stringr::str_remove("_?[A-Z]?\\.rda$") |>
    unique()
}

get_split_files <- function() {
  list(
    "mb21_poly" = c("mb21_poly_A", "mb21_poly_B")
  )
}

download_data <- function(url, dest) {
  tryCatch(
    download.file(url, destfile = dest, mode = "wb"),
    error = glue::glue(
      "Download failed. Check that you have access to the internet and that ",
      "your requested object is one of the following:",
      "{paste0(get_data_file_list(), collapse = '\n')}"
    )
  )
}

