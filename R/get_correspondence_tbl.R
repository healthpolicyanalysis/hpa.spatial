#' Get a correspondence table, either via \code{strayr::read_correspondence_tbl}
#' or by creating one with \code{make_correspondence_tbl}
#'
#' @param from_area The area you want to correspond FROM (i.e. the areas your
#' data are currently in). For example: 'sa1', 'sa2', 'sa3', 'sa4'.
#' @param from_year The year you want to correspond FROM. For example: 2011,
#' 2016.
#' @param from_geo The FROM polygon geography. Helpful if it is not available
#' using \code{from_year} and \code{from_area} in \code{get_polygon}.
#' @param to_area The area you want to correspond TO (i.e. the areas you want
#' your data to be in).
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
#' @return A \code{tibble}.
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

  call <- rlang::expr(read_correspondence_tbl(
    from_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_area))),
    from_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_year))),
    to_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_area))),
    to_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_year))),
    export_dir = rlang::eval_tidy(rlang::expr(!!rlang::quo(export_dir)))
  ))

  cg <- try(suppressMessages(suppressWarnings(rlang::eval_tidy(call))), silent = TRUE)

  # if success, return the CG
  if (!inherits(cg, "try-error")) {
    cg <- cg |>
      dplyr::select(1, 3, ratio) |>
      dplyr::mutate(dplyr::across(1:2, as.character))
    saveRDS(cg, file = out_path)
    return(cg)
  }

  # if it's a (non-standard) ASGS-SA mapping, try making a correspondence table
  maybe_sa <- all(
    !is.null(from_year),
    !is.null(to_year),
    !is.null(from_area),
    !is.null(to_area),
    is.null(from_geo),
    is.null(to_geo)
  )

  if (maybe_sa) {
    is_sa_mapping <- all(
      is_SA_area(from_area),
      is_SA_area(to_area),
      is_SA_year(from_year),
      is_SA_year(to_year)
    )

    if (is_sa_mapping) {
      message("Failed to retrieve correspondence table through {strayr}, making one using a combination of available ASGS correspondence tables")
      cg <- try(suppressMessages(suppressWarnings(
        make_asgs_cg_tbl(
          from_area = from_area,
          from_year = from_year,
          to_area = to_area,
          to_year = to_year
        )
      )), silent = TRUE)

      if (!inherits(cg, "try-error")) {
        saveRDS(cg, file = out_path)
        return(cg)
      }
    }
  }


  # if still can't get a CG, make one using the polygons and mb_pop
  message("Last resort: making correspondence table using shapes and population at mesh block level")

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

  saveRDS(cg, file = out_path)
  cg
}


make_asgs_cg_tbl <- function(from_area,
                             from_year,
                             to_area,
                             to_year) {
  # from and to areas/years are pre-checked with is_SA_area() and is_SA_year()

  years_are_the_same <- from_year == to_year
  areas_are_the_same <- from_area == to_area
  sa_area_is_aggregating <- is_sa_code_aggregating(from_area, to_area)
  # browser()

  # codes are both SAs and they are aggregating up - load the from_area/year and agg up
  if (years_are_the_same & sa_area_is_aggregating) {
    cg <- select_cols_for_aggregating_sa(
      tbl = get_polygon(area = from_area, year = from_year),
      to_area = to_area
    )

    return(cg)
  }

  if (areas_are_the_same & get_sa_year_step(from_year, to_year) > 1) {
    # when the increment in edition is more than 1, these correspondence tables are not released by ABS but can be made by combining multiple.

    n_incremements <- get_sa_year_step(from_year, to_year)

    l_cg_steps <- list()

    for (i in seq_len(n_incremements)) {
      if (i == 1) {
        next_year <- get_next_sa_year_step(from_year)
        prev_year <- from_year
      } else {
        prev_year <- next_year
        next_year <- get_next_sa_year_step(next_year)
      }

      cg_step <- read_correspondence_tbl(
        from_area = from_area,
        from_year = prev_year,
        to_area = to_area,
        to_year = next_year
      ) |>
        dplyr::select(1, 3, ratio) |>
        dplyr::mutate(dplyr::across(!ratio, as.character))

      l_cg_steps <- c(l_cg_steps, list(cg_step))
    }

    lj_cgs <- function(x, y) {
      shared_code_col <- names(x)[names(x) %in% names(y)] |>
        stringr::str_subset(stringr::regex("code", ignore_case = TRUE))
      dplyr::left_join(x, y, by = shared_code_col) |>
        dplyr::select(-dplyr::all_of(shared_code_col))
    }


    cg <- Reduce(lj_cgs, l_cg_steps) |>
      dplyr::mutate(prod = purrr::pmap_dbl(dplyr::pick(dplyr::starts_with("ratio")), prod)) |>
      dplyr::select(dplyr::matches("code", ignore.case = TRUE), ratio = prod) |>
      dplyr::group_by(dplyr::across(-ratio)) |>
      dplyr::summarize(ratio = sum(ratio)) |>
      dplyr::ungroup()

    return(cg)
  }

  stop("couldn't make a table using available ASGS correspondence tables")
}

adjust_correspondence_tbl <- function(tbl) {
  # in some cases, the correspondence table has a 1-to-1 mapping and the ratio = NA.
  # for these cases, assign the ratio to be 2 before the fixing process
  # (which will affect the new value and reduce it to be 1- sum(ratio))
  # this will force the missing ratio to be the remainder of the sum of the other non-NA ratios
  tbl <- tidyr::drop_na(tbl, !ratio)
  tbl$ratio[is.na(tbl$ratio)] <- 2
  code_col <- names(tbl)[1]

  # keep the mappings which have ratios that add up to 1 separate
  tbl_ok <- tbl |>
    dplyr::group_by(!!!rlang::syms(code_col)) |>
    dplyr::filter(sum(ratio) == 1) |>
    dplyr::ungroup()

  # get the mappings where the ratios do NOT add up to 1
  tbl_not_ok <- tbl |>
    dplyr::group_by(!!!rlang::syms(code_col)) |>
    dplyr::filter(sum(ratio) != 1)

  # add the difference from 1 to the largest correspondence ratio
  tbl_not_ok_fixed <-
    tbl_not_ok |>
    dplyr::arrange(dplyr::desc(ratio)) |>
    dplyr::mutate(ratio = ifelse(dplyr::row_number() == 1, ratio + 1 - sum(ratio), ratio)) |>
    dplyr::ungroup()

  rbind(tbl_ok, tbl_not_ok_fixed) |>
    dplyr::arrange(!!!rlang::syms(code_col))
}

select_cols_for_aggregating_sa <- function(tbl, to_area) {
  tbl |>
    tibble::as_tibble() |>
    dplyr::rename_with(tolower) |>
    dplyr::select(1, dplyr::matches(to_area)) |>
    dplyr::select(dplyr::contains("code")) |>
    dplyr::mutate(ratio = 1)
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
