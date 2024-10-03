#' Map data between editions using correspondence tables from the ABS.
#'
#' @param .data A \code{data.frame}(-like) object. Can be passed if codes,
#' values or groups are passed by reference (like in \code{dplyr::mutate()}).
#' @param codes Codes representing locations relevant to the \code{from_area}.
#' SA1 or SA2, for example.
#' @param values Values associated with codes to be allocated to newly mapped
#' codes.
#' @param groups Values associated with codes/values specifying a grouping
#' structure. For example, if there are codes/values for several age groups,
#' then groups will be the grouping variable for the age group associated with
#' the code and value of the same position. Defaults to \code{NULL} (no
#' grouping).
#' @param from_area The area you want to correspond FROM (ie the areas your data
#' are currently in). For example: "sa1", "sa2, "sa3", "sa4".
#' @param from_year The year you want to correspond FROM. For example: 2011,
#' 2016.
#' @param from_geo The FROM polygon geography. Helpful if it is not available
#' using \code{from_year} and \code{from_area} in \code{get_polygon}.
#' @param to_area The area you want to correspond TO (ie the areas you want your
#' data to be in).
#' @param to_year The year you want to correspond TO.
#' @param to_geo The TO polygon geography. Helpful if it is not available
#' using \code{to_year} and \code{to_area} in \code{get_polygon}.
#' @param correspondence_tbl A correspondence table to be used to map values
#' between code sets. It should contain 3 columns: (1) code set FROM which
#' values are being mapped, (2) code set TO which values are being mapped, and
#' (3) a column named "ratio" containing the proportion/probability of the
#' value(s) being mapped between the from- and to- code pair (row). Defaults to
#' \code{NULL}, in which case it will attempt to get the correspondence table
#' from the ABS and, if not available, it will create a correspondence table
#' based on the overlap of the shapes and the residential population in the
#' intersection (uses \code{mb_geo} argument).
#' @param mb_geo An \code{{sf}} POINT object where the points are the centroids
#' of a small area (intended to be mesh blocks but can be any other space that's
#' small enough to be useful. Should also include a column, \code{Person},
#' with the population within that area. Defaults to use Mesh Blocks (2021) and
#' with 2021 census data. See \code{get_mb21_pop()}.
#' @param value_type Whether the data are unit level or aggregate level data.
#' Unit level data is randomly allocated to new locations based on proportions
#' in the correspondence table, aggregate data is dispersed based on the
#' proportion across the (potentially multiple) mapped codes.
#' @param export_fname The file name for the saved correspondence table file
#' (applicable if \code{from_geo}) and \code{to_geo} are used instead of areas
#' and years).
#' @param round_values Whether or not to round the resulting mapped values to be whole
#' numbers (maybe be useful when mapping count, aggregate values which may
#' otherwise return decimal values in the mapped areas).
#' @param seed A random seed (integer). May be useful for ensuring mappings of
#' unit level data are reproducible (as these use the mapping probabilities
#' for randomly allocating observations to the new geographies and may be
#' different between runs with the same data/inputs).
#' @param quiet whether to be quiet about warnings. Set package level quiet-ness
#' with \code{options(hpa.spatial.quiet = TRUE)}.
#'
#' @return A \code{data.frame}.
#' @export
#'
#' @examples
#' map_data_with_correspondence(
#'   codes = c(107011130, 107041149),
#'   values = c(10, 10),
#'   from_area = "sa2",
#'   from_year = 2011,
#'   to_area = "sa2",
#'   to_year = 2016,
#'   value_type = "units"
#' )
#' map_data_with_correspondence(
#'   codes = c(107011130, 107041149),
#'   values = c(10, 10),
#'   from_area = "sa2",
#'   from_year = 2011,
#'   to_area = "sa2",
#'   to_year = 2016,
#'   value_type = "aggs"
#' )
map_data_with_correspondence <- function(.data = NULL,
                                         codes,
                                         values,
                                         groups = NULL,
                                         from_area = NULL,
                                         from_year = NULL,
                                         from_geo = NULL,
                                         to_area = NULL,
                                         to_year = NULL,
                                         to_geo = NULL,
                                         correspondence_tbl = NULL,
                                         mb_geo = get_mb21_pop(),
                                         value_type = c("units", "aggs"),
                                         export_fname = NULL,
                                         round_values = FALSE,
                                         seed = NULL,
                                         quiet = getOption("hpa.spatial.quiet", FALSE)) {
  # extract codes and values from .data
  if (!is.null(.data)) {
    .data <- dplyr::as_tibble(.data)

    values_name <- try(as.character(substitute(values)), silent = FALSE)
    if (inherits(try(as.character(substitute(values)), silent = FALSE), "character")) {
      assertthat::are_equal(length(as.character(substitute(values))), 1)
      if (values_name %in% names(.data)) {
        values <- dplyr::pull(.data, dplyr::all_of(values_name))
      } else {
        # check whether it was passed as a vector
        values <- try(values)
        # if not, access from .data
        if (inherits(values, "try-error")) {
          values <- rlang::eval_tidy(rlang::enexpr(values), data = .data)
        }
      }
    } else {
      values <- rlang::eval_tidy(rlang::enexpr(values), data = .data)
    }

    if (inherits(try(as.character(substitute(codes)), silent = FALSE), "character")) {
      assertthat::are_equal(length(as.character(substitute(codes))), 1)
      codes_name <- rlang::eval_tidy(as.character(substitute(codes)))
      if (codes_name %in% names(.data)) {
        codes <- dplyr::pull(.data, dplyr::all_of(codes_name))
      } else {
        # check whether it was passed as a vector
        codes <- try(codes)
        # if not, access from .data
        if (inherits(codes, "try-error")) {
          codes <- rlang::eval_tidy(rlang::enexpr(codes), data = .data)
        }
      }
    } else {
      codes <- rlang::eval_tidy(rlang::enexpr(codes), data = .data)
    }

    groups_values <- try(groups, silent = TRUE)
    groups_name <- try(as.character(substitute(groups)), silent = FALSE)
    if (inherits(groups_values, "try-error")) {
      if (length(substitute(groups)) > 1) {
        groups_name <- as.list(as.character(substitute(groups))[-1])
      } else {
        groups_name <- as.list(as.character(substitute(groups)))
      }

      groups <- lapply(groups_name, {
        \(x) dplyr::pull(.data, dplyr::all_of(x))
      })
    } else {
      groups <- groups_values
      if (length(groups_name) - 1 == length(groups)) {
        groups_name <- paste0("grp", 1:(length(groups_name) - 1))
      } else {
        groups_name <- NA
      }
    }
  } else {
    groups_name <- NA
    values_name <- NA
  }

  value_type <- match.arg(value_type)

  ### CREATE CORRESPONDENCE TBL
  if (is.null(correspondence_tbl)) {
    ct_provided <- FALSE

    correspondence_tbl <- get_correspondence_tbl(
      from_area = from_area,
      from_year = from_year,
      from_geo = from_geo,
      to_area = to_area,
      to_year = to_year,
      to_geo = to_geo,
      export_fname = export_fname
    )
  } else {
    ct_provided <- TRUE
  }

  # not all the sum of the ratios add up to 1 in the correspondence tables.
  # For those that don't, add/subtract the difference from the majority target code by adjust_correspondence_tbl()
  correspondence_tbl <- adjust_correspondence_tbl(correspondence_tbl)

  # remove codes that aren't in the correspondence table
  bad_codes <- codes[!codes %in% correspondence_tbl[[1]]]

  if (length(bad_codes) != 0 & !quiet) {
    if (length(bad_codes) > 1) {
      message(glue::glue(
        "\nThe following {length(bad_codes)} codes were passed but are not ",
        "valid (within the from geography) codes:"
      ))
    } else {
      message(glue::glue(
        "\nThe following code was passed but is not a valid code:"
      ))
    }

    for (c in bad_codes) {
      message(c)
    }
  }

  df <- dplyr::tibble(codes = as.character(codes), values) |>
    dplyr::filter(codes %in% correspondence_tbl[[1]])

  if (is.null(groups)) {
    mapped_df <- .map_data_with_ct(
      codes = df$codes,
      values = df$values,
      correspondence_tbl = correspondence_tbl,
      value_type = value_type,
      bad_codes = bad_codes,
      round_values = round_values,
      seed = seed
    )
    return(clean_mapped_tbl(mapped_df, values_name = values_name, groups_name = groups_name))
  }


  if (!is.null(groups)) {
    # if grouped are used call self (map_data_with_correspondence() for each group)
    if (!inherits(groups, "list")) {
      groups <- list(groups)
    }

    for (g in groups) {
      stopifnot(length(g) == length(codes))
    }

    stopifnot(length(codes) == length(values))

    names(groups) <- paste0("grp", seq_along(groups))
    groups_df <- do.call(dplyr::bind_cols, groups)

    df_res <- split(
      dplyr::bind_cols(dplyr::tibble(codes = codes, values = values), groups_df),
      f = groups,
      drop = TRUE
    ) |>
      lapply(\(x) {
        mapped_df <- .map_data_with_ct(
          codes = x$codes,
          values = x$values,
          correspondence_tbl = correspondence_tbl,
          value_type = value_type,
          bad_codes = bad_codes,
          round_values = round_values,
          seed = seed
        )

        grp_cols <- x |>
          dplyr::select(-dplyr::all_of(c("codes", "values"))) |>
          (\(x) {
            names(x) <- paste0("grp", 1:ncol(x))
            x
          })() |>
          dplyr::slice_head(n = 1)

        dplyr::bind_cols(
          mapped_df,
          grp_cols
        )
      }) |>
      dplyr::bind_rows() |>
      clean_mapped_tbl(values_name = values_name, groups_name = groups_name)

    return(df_res)
  }
}


get_mapping_tbl_col_name <- function(area, year) {
  if (length(area) > 1) {
    col_names <- lapply(area, \(x) get_mapping_tbl_col_name(x, year))
    return(do.call("c", col_names))
  }

  if (is_SA_area(area)) {
    glue::glue("{clean_sa(area)}_code_{year}")
  } else {
    stop("Not sure how to make col names for non-SA areas yet...")
  }
}


get_asgs_table <- function(from_area, to_area, year) {
  stopifnot(as.character(year) %in% c("2011", "2016", "2021"))

  valid_areas <- get_sa_codes()
  stopifnot(from_area %in% valid_areas)
  stopifnot(to_area %in% valid_areas)
  stopifnot(which(valid_areas == from_area) < which(valid_areas == to_area))

  cols <- glue::glue("{tolower(c(from_area, to_area))}_code_{year}")

  get(paste0("asgs_", year)) |>
    dplyr::select(dplyr::all_of(cols)) |>
    dplyr::distinct()
}

clean_mapped_tbl <- function(.data, values_name, groups_name) {
  if (!is.na(values_name)) {
    .data <- dplyr::rename(.data, !!values_name := values)
  }

  if (!any(is.na(groups_name))) {
    rename_vec <- names(.data)[3:ncol(.data)]
    names(rename_vec) <- groups_name
    .data <- dplyr::rename(.data, dplyr::all_of(rename_vec))
  }
  .data |>
    tibble::remove_rownames() |>
    tibble::as_tibble()
}


clean_sa <- function(x) {
  stringr::str_trim(tolower(x))
}

is_SA_area <- function(x) {
  clean_sa(x) %in% get_sa_codes()
}

get_sa_codes <- function() {
  c("sa1", "sa2", "sa3", "sa4", "gcc")
}

get_sa_years <- function() {
  c(2011, 2016, 2021)
}

sa_code_level <- function(area) {
  stopifnot(is_SA_area(area))
  which(get_sa_codes() == area)
}

is_SA_year <- function(year) {
  as.character(year) %in% as.character(get_sa_years())
}

sa_year_level <- function(year) {
  stopifnot(is_SA_year(year))
  which(get_sa_years() == year)
}

get_next_sa_year_step <- function(year) {
  stopifnot(is_SA_year(year))
  years <- get_sa_years()
  current_year_idx <- which(years == year)
  stopifnot(current_year_idx != length(years))

  # return the next year/edition
  years[current_year_idx + 1]
}

get_sa_year_step <- function(from_year, to_year) {
  sa_year_level(to_year) - sa_year_level(from_year)
}

is_sa_code_aggregating <- function(from_area, to_area) {
  stopifnot(is_SA_area(from_area))
  stopifnot(is_SA_area(to_area))

  sa_code_level(from_area) < sa_code_level(to_area)
}

clean_year <- function(x) {
  stringr::str_trim(x)
}
