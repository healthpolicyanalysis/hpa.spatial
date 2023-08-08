#' Map data between editions using correspondence tables from the ABS.
#'
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
#' @param value_type Whether the data are unit level or aggregate level data.
#' Unit level data is randomly allocated to new locations based on proportions
#' in the correspondence table, aggregate data is dispersed based on the
#' proportion across the (potentially multiple) mapped codes.
#' @param round Whether or not to round the resulting mapped values to be whole
#' numbers (maybe be useful when mapping count, aggregate values which may
#' otherwise return decimal values in the mapped areas).
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
map_data_with_correspondence <- function(codes,
                                         values,
                                         groups = NULL,
                                         from_area,
                                         from_year,
                                         to_area,
                                         to_year,
                                         value_type = c("units", "aggs"),
                                         round = FALSE) {

  if(!is.null(groups)) {
    stopifnot(length(codes) == length(groups))
    stopifnot(length(codes) == length(values))
    call <- match.call()

    df_res <- split(
      data.frame(codes = codes, values = values, groups = groups),
      f = groups
    ) |>
      lapply(\(x) {
               call$codes <- x$codes
               call$values <- x$values
               call$groups <- NULL
               eval(call, envir = parent.frame()) |>
                 dplyr::mutate(grp = x$groups[1])
               }) |>
      (\(x) do.call("rbind", x))()

    return(df_res)
  }

  value_type <- match.arg(value_type)
  stopifnot(length(codes) == length(values))

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
      return(mapped_df)
    }

    if (value_type == "aggs") {
      mapped_df <- mapped_df |>
        dplyr::group_by(!!rlang::sym(names(mapped_df)[1])) |>
        dplyr::summarize(values = sum(values)) |>
        (\(.data) if (round) dplyr::mutate(.data, values = round(values)) else .data)()

      return(mapped_df)
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

    return(eval(call, envir = parent.frame()))
  }

  call <- match.call.defaults()
  call$codes <- NULL
  call$values <- NULL
  call$value_type <- NULL
  call$round <- NULL
  call <- rlang::call_modify(call, !!!list("groups" = rlang::zap()))

  call[[1]] <- as.name("read_correspondence_tbl")
  correspondence_tbl <- eval(call, envir = parent.frame())



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
      mapping_df_filtered <- mapping_df[mapping_df[, 1] == code, ]

      if (any(is.na(mapping_df_filtered[[3]]))) {
        na_count <- sum(is.na(mapping_df_filtered[[3]]))
        sum_ratio <- sum(mapping_df_filtered[[3]], na.rm = TRUE)
        mapping_df_filtered[is.na(mapping_df_filtered[[3]]), 3] <- (1 - sum_ratio) / na_count
      }
      sample(mapping_df_filtered[[2]], size = 1, prob = mapping_df_filtered[[3]])
    }

    mapped_df <- df |>
      dplyr::rowwise() |>
      dplyr::mutate(codes = f_assign_code(code = codes, mapping_df = correspondence_tbl[, c(1, 3, 5)]))

    names(mapped_df)[1] <- names(correspondence_tbl)[3]

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
      dplyr::group_by(!!rlang::sym(names(correspondence_tbl)[3])) |>
      dplyr::summarize(values = sum(values))
  }

  stopifnot(all.equal(sum(mapped_df$values), sum(values[!codes %in% bad_codes])))

  if(value_type == "aggs" & round) {
    mapped_df <- dplyr::mutate(mapped_df, values = round(values))
  }

  mapped_df
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
