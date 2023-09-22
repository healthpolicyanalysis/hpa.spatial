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
#' @param to_area The area you want to correspond TO (ie the areas you want your
#' data to be in).
#' @param to_year The year you want to correspond TO.
#' @param mb_geo an \code{{sf}} POINT object where the points are the centroids
#' of a small area (intended to be mesh blocks but can be any other space that's
#' small enough to be useful. Should also include a column, \code{Person},
#' with the population within that area. Defaults to use Mesh Blocks (2021) and
#' with 2021 census data. See \code{hpa.spatial::mb21_pop}.
#' @param value_type Whether the data are unit level or aggregate level data.
#' Unit level data is randomly allocated to new locations based on proportions
#' in the correspondence table, aggregate data is dispersed based on the
#' proportion across the (potentially multiple) mapped codes.
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
#'
map_data_with_correspondence <- function(.data = NULL,
                                         codes,
                                         values,
                                         groups = NULL,
                                         from_area,
                                         from_year,
                                         to_area,
                                         to_year,
                                         mb_geo,
                                         value_type = c("units", "aggs"),
                                         round = FALSE,
                                         seed = NULL) {
  if (missing(mb_geo)) {
    mb_geo <- get_mb21_pop()
  }
  if (!is.null(.data)) {
    # if .data is passed, extract the codes and values from the columns of .data

    # get codes
    codes <- try(eval(substitute(codes), .data), silent = TRUE)
    if (inherits(codes, "try-error")) {
      msg <- codes[[1]]
      codes <- try(codes, silent = TRUE)
      if (inherits(codes, "try-error")) {
        stop(msg)
      }
    }

    # get values
    # extract the name of the column used for values
    values_name <- try(as.character(substitute(values)), silent = FALSE)
    if (inherits(values_name, "try-error")) {
      values_name <- NA
    } else {
      if(length(values_name) != 1 | !all(values_name %in% names(.data))) {
        values_name <- NA
      }
    }
    values_col <- try(eval(substitute(values), .data), silent = TRUE)
    if (inherits(values_col, "try-error")) {
      values_name <- NA # if the value aren't extracted as column from .data, use default
      msg <- values_col[[1]]
      values <- try(values, silent = TRUE)
      if (inherits(values, "try-error")) {
        stop(msg)
      }
    } else {
      values <- values_col
    }

    # get groups
    groups_name <- try(as.character(substitute(groups)), silent = FALSE)
    if (inherits(groups_name, "try-error")) {
      groups_name <- NA
    } else {
      if(length(groups_name) != 1 | !all(groups_name %in% names(.data))) {
        groups_name <- NA
      }
    }
    groups <- try(eval(substitute(groups), .data), silent = TRUE)
    if (inherits(groups, "try-error")) {
      groups_name <- NA # if the value aren't extracted as column from .data, use default
      msg <- groups[[1]]
      values <- try(groups, silent = TRUE)
      if (inherits(groups, "try-error")) {
        stop(msg)
      }
    }
  } else {
    groups_name <- NA
    values_name <- NA
  }

  if (!is.null(groups)) {
    stopifnot(length(codes) == length(groups))
    stopifnot(length(codes) == length(values))
    call <- match.call()
    call$groups <- NULL
    call$.data <- NULL

    df_res <- split(
      data.frame(codes = codes, values = values, groups = groups),
      f = groups
    ) |>
      lapply(\(x) {
        call$codes <- x$codes
        call$values <- x$values
        eval(call, envir = parent.frame()) |>
          dplyr::mutate(grp = x$groups[1])
      }) |>
      (\(x) do.call("rbind", x))()

    return(clean_mapped_tbl(df_res, values_name = values_name, groups_name = groups_name))
  }

  value_type <- match.arg(value_type)
  stopifnot(length(codes) == length(values))

  if(any(missing(from_year), missing(to_year), missing(from_area), missing(to_area))) {
    maybe_sa <- TRUE
  } else {

  }

  maybe_sa <- all(!missing(from_year), !missing(to_year), !missing(from_area), !missing(to_area))

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
        return(clean_mapped_tbl(mapped_df, values_name = values_name, groups_name = groups_name))
      }

      if (value_type == "aggs") {
        mapped_df <- mapped_df |>
          dplyr::group_by(!!rlang::sym(names(mapped_df)[1])) |>
          dplyr::summarize(values = sum(values)) |>
          (\(.data) if (round) dplyr::mutate(.data, values = round(values)) else .data)()

        return(clean_mapped_tbl(mapped_df, values_name = values_name, groups_name = groups_name))
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
      call <- match.call.defaults()
      call$to_area <- from_area

      df_edition_mapped <- eval(call, envir = parent.frame())

      call <- match.call.defaults()
      call$from_year <- to_year
      call$codes <- df_edition_mapped[[1]]
      call$values <- df_edition_mapped$values


      return(clean_mapped_tbl(eval(call, envir = parent.frame()), values_name = values_name, groups_name = groups_name))
    }
  }

  call <- match.call.defaults()
  call$codes <- NULL
  call$values <- NULL
  call$value_type <- NULL
  call$round <- NULL
  call$.data <- NULL
  call$seed <- NULL
  call <- rlang::call_modify(call, !!!list("groups" = rlang::zap()))

  call[[1]] <- as.name("get_correspondence_tbl")

  p_env <- rlang::env_clone(parent.frame())
  withr::with_environment(p_env, {
    withr::with_package(
      "hpa.spatial",
      correspondence_tbl <- eval(call, envir = rlang::current_env())
    )
  })

  # remove codes that aren't in the correspondence table
  bad_codes <- codes[!codes %in% correspondence_tbl[[1]]]

  if (length(bad_codes) != 0) {
    if (length(bad_codes) > 1) {
      message(glue::glue(
        "\nThe following {length(bad_codes)} codes were passed but are not valid {from_area} ({from_year}) codes:"
      ))
    } else {
      message(glue::glue(
        "\nThe following code was passed but is not a valid {from_area} ({from_year}) code:"
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
      if(is.null(seed)) {
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

    # not all the sum of the ratios add up to 1 in the correspondence tables.
    # For those that don't, add/subtract the difference from the majority target code by adjust_correspondence_tbl()
    correspondence_tbl <- adjust_correspodence_tbl(correspondence_tbl)
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
  if(!is.na(values_name)) {
    .data <- dplyr::rename(.data, !!values_name := values)
  }
  if(!is.na(groups_name)) {
    .data <- dplyr::rename(.data, !!groups_name := grp)
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


#' @importFrom strayr read_correspondence_tbl
#' @export
strayr::read_correspondence_tbl


#' get a correspondence table, either via \code{strayr::read_correspondence_tbl}
#' or by creating one with \code{make_correspondence_tbl}.
#'
#' @param from_area The area you want to correspond FROM (ie the areas your data
#' are currently in). For example: "sa1", "sa2, "sa3", "sa4".
#' @param from_year The year you want to correspond FROM. For example: 2011,
#' 2016.
#' @param to_area The area you want to correspond TO (ie the areas you want your
#' data to be in).
#' @param to_year The year you want to correspond TO.
#' @param export_dir The directory to store the downloaded data.
#' @param mb_geo mesh blocks data with census population. Defaults to using the
#' 2021 edition mesh blocks and 2021 census data (see
#' \code{hpa.spatial::mb21_pop}).
#'
#' @return a \code{tibble}.
#' @export
#'
#' @examples
#' get_correspondence_tbl(from_area = "sa2", from_year = 2021, to_area = "LHN")
get_correspondence_tbl <- function(from_area,
                                   from_year,
                                   to_area,
                                   to_year,
                                   export_dir = tempdir(),
                                   mb_geo = get_mb21_pop()) {

  call <- match.call.defaults()
  call$mb_geo <- NULL
  call[[1]] <- as.name("read_correspondence_tbl")
  withr::with_package("hpa.spatial", {
    cg <- try(eval(call, envir = parent.frame()), silent = TRUE)
  })

  if (inherits(cg, "try-error")) {
    message('Failed to retrieve correspondence table through {strayr}, making correspondence table')

    if(!missing(from_year)) {
      from_polygon <- get_polygon(area = from_area, year = from_year, crs = 7844)
    } else {
      from_polygon <- get_polygon(area = from_area, crs = 7844)
    }

    if(!missing(to_year)) {
      to_polygon <- get_polygon(area = to_area, year = to_year, crs = 7844)
    } else {
      to_polygon <- get_polygon(area = to_area, crs = 7844)
    }

    make_correspondence_tbl(from_geo = from_polygon, to_geo = to_polygon, mb_geo = mb_geo)
  } else {
    cg |>
      dplyr::select(1, 3, ratio) |>
      dplyr::mutate(dplyr::across(1:2, as.character))
  }
}
