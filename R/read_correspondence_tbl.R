read_correspondence_tbl <- function(from_area,
                                    from_year,
                                    to_area,
                                    to_year,
                                    export_dir = tempdir()) {
  if (!dir.exists(export_dir)) {
    stop("export_dir provided does not exist: ", export_dir)
  }
  url <- "https://github.com/wfmackey/absmapsdata/raw/master/R/sysdata.rda"
  out_path <- file.path(export_dir, "cg_tables.rda")
  if (!file.exists(out_path)) {
    tryCatch(download.file(url, destfile = out_path, mode = "wb"),
      error = "Download failed. Check that you have access to the internet and that your requested object is available at https://github.com/wfmackey/absmapsdata/tree/master/data"
    )
  } else {
    message("Reading file found in ", export_dir)
  }
  load(out_path)

  e <- rlang::current_env()
  objs <- ls(envir = e)

  for (.name in objs) {
    x <- get(.name, envir = e)
    if (stringr::str_detect(.name, ".csv")) {
      newName <- stringr::str_remove(.name, ".csv")
      assign(newName, x, envir = e)
      rm(list = .name, envir = e)
    }
  }

  filename <- paste("CG", toupper(from_area), from_year, toupper(to_area),
    to_year,
    sep = "_"
  )
  cg_tbl <- try(get(filename))
  if (inherits(cg_tbl, "try-error")) {
    message("The following correspondence tables are available:")
    for (obj in ls()[str_detect(ls(), "^CG_")]) {
      message(obj)
    }
    stop("Correspondence table not available.")
  }
  cg_tbl
}
