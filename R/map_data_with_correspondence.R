#' Map data between editions using correspondence tables from the ABS.
#'
#' @param .data a \code{data.frame}(-like) object. Can be passed if codes,
#' values or groups are passed by reference (like in \code{dplyr::mutate()}).
#' @param codes codes representing locations relevant to the \code{from_area}.
#' SA1 or SA2, for example.
#' @param values values associated with codes to be alloocated to newly mapped
#' codes.
#' @param groups values associated with codes/values specifying a grouping
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
#' @param mb_geo an \code{{sf}} POINT object where the points are the centroids
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
#' @param round Whether or not to round the resulting mapped values to be whole
#' numbers (maybe be useful when mapping count, aggregate values which may
#' otherwise return decimal values in the mapped areas).
#' @param seed A random seed (integer). May be useful for ensuring mappings of
#' unit level data are reproducible (as these use the mapping probabilities
#' for randomly allocating observations to the new geographies and may be
#' different between runs with the same data/inputs).
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
                                         mb_geo = get_mb21_pop(),
                                         value_type = c("units", "aggs"),
                                         export_fname = NULL,
                                         round = FALSE,
                                         seed = NULL) {
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
        if(inherits(values, "try-error")) {
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
        if(inherits(codes, "try-error")) {
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

  multiple_groups <- inherits(groups, "list")

  if (!is.null(groups)) {
    if (multiple_groups) {
      assertthat::assert_that(inherits(groups, "list"))
    } else {
      groups <- list(groups)
    }
    for (g in groups) {
      stopifnot(length(g) == length(codes))
    }

    stopifnot(length(codes) == length(values))
    groups_df <- do.call("cbind.data.frame", groups)

    df_res <- split(
      cbind(data.frame(codes = codes, values = values), groups_df),
      f = groups,
      drop = TRUE
    ) |>
      lapply(\(x) {
        call <- rlang::expr(map_data_with_correspondence(
          codes = x$codes,
          values = x$values,
          from_area = !!rlang::quo(from_area),
          from_year = !!rlang::quo(from_year),
          from_geo = !!rlang::quo(from_geo),
          to_area = !!rlang::quo(to_area),
          to_year = !!rlang::quo(to_year),
          to_geo = !!rlang::quo(to_geo),
          value_type = !!rlang::quo(value_type)
        ))

        groups_df <- x |>
          dplyr::select(-dplyr::all_of(c("codes", "values"))) |>
          (\(x) {
            names(x) <- paste0("grp", 1:ncol(x))
            x
          })() |>
          dplyr::slice_head(n = 1)

        dplyr::bind_cols(
          rlang::eval_tidy(call),
          groups_df
        )
      }) |>
      (\(x) do.call("rbind", x))()

    return(clean_mapped_tbl(df_res, values_name = values_name, groups_name = groups_name))
  }

  value_type <- match.arg(value_type)
  stopifnot(length(codes) == length(values))
  maybe_sa <- all(
    !is.null(from_year),
    !is.null(to_year),
    !is.null(from_area),
    !is.null(to_area),
    is.null(from_geo),
    is.null(to_geo)
  )

  if (maybe_sa) {
    if (is_SA(from_area) & is_SA(to_area) & clean_year(from_year) == clean_year(to_year)) {
      # if the areas are both SA's and the year is the same, this is the process
      # of aggregating up (i.e. from SA2 to SA3) and can be done without
      # correspondence tables but just with the asgs tables.
      asgs_tbl <- get_asgs_table(
        from_area = clean_sa(from_area),
        to_area = clean_sa(to_area),
        year = clean_year(from_year)
      )

      mapped_df <- cbind(asgs_tbl[asgs_tbl[[1]] %in% codes, 2, drop = FALSE], values)

      if (value_type == "units") {
        return(clean_mapped_tbl(
          mapped_df,
          values_name = values_name,
          groups_name = groups_name
        ))
      }

      if (value_type == "aggs") {
        mapped_df <- mapped_df |>
          dplyr::group_by(!!rlang::sym(names(mapped_df)[1])) |>
          dplyr::summarize(values = sum(values)) |>
          (\(.data) if (round) dplyr::mutate(.data, values = round(values)) else .data)()

        return(clean_mapped_tbl(
          mapped_df,
          values_name = values_name,
          groups_name = groups_name
        ))
      }
    }

    if (is_SA(from_area) & is_SA(to_area) &
      clean_sa(from_area) != clean_sa(to_area) &
      clean_year(from_year) != clean_year(to_year)
    ) {
      # if the areas are both SA's and the years are different, then the user is
      # wanting to both map using the correspondence tables from one edition to another
      # AND aggregate the data assigned to map codes to a new ASGS level (i.e. SA2 to SA3)

      # approach... call function recursively to:
      #     > map editions (from_area to from_area)
      #     > aggregate up area levels

      call <- rlang::expr(map_data_with_correspondence(
        codes = codes,
        values = values,
        from_area = !!rlang::quo(from_area),
        from_year = !!rlang::quo(from_year),
        to_area = !!rlang::quo(from_area),
        to_year = !!rlang::quo(to_year),
        value_type = !!rlang::quo(value_type)
      ))

      df_edition_mapped <- rlang::eval_tidy(call)

      call <- rlang::expr(map_data_with_correspondence(
        codes = df_edition_mapped[[1]],
        values = df_edition_mapped[[2]],
        from_area = !!rlang::quo(from_area),
        from_year = !!rlang::quo(to_year), # have already mapped edition
        to_area = !!rlang::quo(to_area),
        to_year = !!rlang::quo(to_year),
        value_type = !!rlang::quo(value_type)
      ))

      mapped_df <- rlang::eval_tidy(call)

      return(clean_mapped_tbl(mapped_df, values_name = values_name, groups_name = groups_name))
    }
  }

  call <- rlang::expr(get_correspondence_tbl(
    from_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_area))),
    from_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_year))),
    from_geo = rlang::eval_tidy(rlang::expr(!!rlang::quo(from_geo))),
    to_area = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_area))),
    to_year = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_year))),
    to_geo = rlang::eval_tidy(rlang::expr(!!rlang::quo(to_geo))),
    export_fname = rlang::eval_tidy(rlang::expr(!!rlang::quo(export_fname)))
  ))

  correspondence_tbl <- rlang::eval_tidy(call)
  # not all the sum of the ratios add up to 1 in the correspondence tables.
  # For those that don't, add/subtract the difference from the majority target code by adjust_correspondence_tbl()
  correspondence_tbl <- adjust_correspodence_tbl(correspondence_tbl)

  # remove codes that aren't in the correspondence table
  bad_codes <- codes[!codes %in% correspondence_tbl[[1]]]

  if (length(bad_codes) != 0) {
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

  df <- data.frame(codes = as.character(codes), values) |>
    dplyr::filter(codes %in% correspondence_tbl[[1]])


  if (value_type == "units") {
    # randomly assign codes to new mapped codes based on ratios
    f_assign_code <- function(code, mapping_df) {
      mapping_df_filtered <- dplyr::filter(mapping_df, mapping_df[[1]] == code)

      if (any(is.na(mapping_df_filtered[[3]]))) {
        na_count <- sum(is.na(mapping_df_filtered[[3]]))
        sum_ratio <- sum(mapping_df_filtered[[3]], na.rm = TRUE)
        mapping_df_filtered[is.na(mapping_df_filtered[[3]]), 3] <- (1 - sum_ratio) / na_count
      }
      if (is.null(seed)) {
        sample(mapping_df_filtered[[2]], size = 1, prob = mapping_df_filtered[[3]])
      } else {
        withr::with_seed(seed, {
          sample(mapping_df_filtered[[2]], size = 1, prob = mapping_df_filtered[[3]])
        })
      }
    }

    mapped_df <- df |>
      dplyr::rowwise() |>
      dplyr::mutate(codes = f_assign_code(code = codes, mapping_df = correspondence_tbl))

    names(mapped_df)[1] <- names(correspondence_tbl)[2]

    stopifnot(nrow(mapped_df) == length(values[!codes %in% bad_codes]))
  }

  if (value_type == "aggs") {
    stopifnot(length(codes) == length(unique(codes)))


    mapped_df <-
      df |>
      dplyr::left_join(correspondence_tbl, by = c("codes" = names(correspondence_tbl)[1])) |>
      dplyr::mutate(values = values * ratio) |>
      dplyr::group_by(!!rlang::sym(names(correspondence_tbl)[2])) |>
      dplyr::summarize(values = sum(values))
  }

  stopifnot(all.equal(sum(mapped_df$values), sum(values[!codes %in% bad_codes])))

  if (value_type == "aggs" & round) {
    mapped_df <- dplyr::mutate(mapped_df, values = round(values))
  }


  clean_mapped_tbl(mapped_df, values_name = values_name, groups_name = groups_name)
}


get_mapping_tbl_col_name <- function(area, year) {
  if (length(area) > 1) {
    col_names <- lapply(area, \(x) get_mapping_tbl_col_name(x, year))
    return(do.call("c", col_names))
  }

  if (is_SA(area)) {
    glue::glue("{clean_sa(area)}_code_{year}")
  } else {
    stop("Not sure how to make col names for non-SA areas yet...")
  }
}


get_asgs_table <- function(from_area, to_area, year) {
  stopifnot(as.character(year) %in% c("2011", "2016", "2021"))

  valid_areas <- c("sa1", "sa2", "sa3", "sa4", "gcc")
  stopifnot(from_area %in% valid_areas)
  stopifnot(to_area %in% valid_areas)
  stopifnot(which(valid_areas == from_area) < which(valid_areas == to_area))

  cols <- glue::glue("{tolower(c(from_area, to_area))}_code_{year}")

  get(paste0("asgs_", year)) |>
    dplyr::select(dplyr::all_of(cols)) |>
    dplyr::distinct()
}

adjust_correspodence_tbl <- function(tbl) {
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

is_SA <- function(x) {
  clean_sa(x) %in% c("sa1", "sa2", "sa3", "sa4", "gcc")
}

clean_year <- function(x) {
  stringr::str_trim(x)
}
