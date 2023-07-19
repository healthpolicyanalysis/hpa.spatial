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
