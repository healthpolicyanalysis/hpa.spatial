#' Map data between editions using correspondence tables from the ABS.
#'
#' @param codes codes representing locations relevant to the \code{fromArea}.
#' SA1 or SA2, for example.
#' @param values values associated with codes to be alloocated to newly mapped
#' codes.
#' @param fromArea The area you want to correspond FROM (ie the areas your data
#' are currently in). For example: "sa1", "sa2, "sa3", "sa4".
#' @param fromYear The year you want to correspond FROM. For example: 2011,
#' 2016.
#' @param toArea The area you want to correspond TO (ie the areas you want your
#' data to be in).
#' @param toYear The year you want to correspond TO.
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
#'   fromArea = "sa2",
#'   fromYear = 2011,
#'   toArea = "sa2",
#'   toYear = 2016,
#'   value_type = "units"
#' )
#' map_data_with_correspondence(
#'   codes = c(107011130, 107041149),
#'   values = c(10, 10),
#'   fromArea = "sa2",
#'   fromYear = 2011,
#'   toArea = "sa2",
#'   toYear = 2016,
#'   value_type = "aggs"
#' )
#'
map_data_with_correspondence <- function(codes,
                                         values,
                                         fromArea,
                                         fromYear,
                                         toArea,
                                         toYear,
                                         value_type = c("units", "aggs"),
                                         round = FALSE) {

  value_type <- match.arg(value_type)
  stopifnot(length(codes) == length(values))

  if(is_SA(fromArea) & is_SA(toArea) & clean_year(fromYear) == clean_year(toYear)) {
    # if the areas are both SA's and the year is the same, this is the process
    # of aggregating up (i.e. from SA2 to SA3) and can be done without
    # correspondence tables but just with the asgs tables.
    asgs_tbl <- get_asgs_table(
      fromArea = clean_sa(fromArea),
      toArea = clean_sa(toArea),
      year = clean_year(fromYear)
    )

    mapped_df <- cbind(asgs_tbl[asgs_tbl[[1]] %in% codes, 2, drop = FALSE], values)

    if(value_type == "units"){
      return(mapped_df)
    }

    if(value_type == "aggs") {
      mapped_df <- mapped_df |>
        dplyr::group_by(!!rlang::sym(names(mapped_df)[1])) |>
        dplyr::summarize(values = sum(values)) |>
        (\(.data) if (round) dplyr::mutate(.data, values = round(values)) else .data)()

      return(mapped_df)
    }
  }

  if(is_SA(fromArea) & is_SA(toArea) &
     clean_sa(fromArea) != clean_sa(toArea) &
     clean_year(fromYear) != clean_year(toYear)
  ){
    # if the areas are both SA's and the years are different, then the user is
    # wanting to both map using the correspondence tables from one edition to another
    # AND aggregate the data assigned to map codes to a new ASGS level (i.e. SA2 to SA3)

    # approach... call function recursively to:
    #     > map editions (fromArea to fromArea)
    #     > aggregate up area levels
    call <- match.call.defaults()
    call$toArea <- fromArea

    df_edition_mapped <- eval(call, envir = parent.frame())

    call <- match.call.defaults()
    call$fromYear <- toYear
    call$codes <- df_edition_mapped[[1]]
    call$values <- df_edition_mapped$values

    return(eval(call, envir = parent.frame()))
  }

  call <- match.call.defaults()
  call$codes <- NULL
  call$values <- NULL
  call$value_type <- NULL
  call$round <- NULL

  call[[1]] <- as.name("get_correspondence_absmaps")
  correspondence_tbl <- eval(call, envir = parent.frame())



  # remove codes that aren't in the correspondence table
  bad_codes <- codes[!codes %in% correspondence_tbl[[1]]]

  if (length(bad_codes) != 0) {
    if (length(bad_codes) > 1) {
      message(glue::glue(
        "\nThe following {length(bad_codes)} codes were passed but are not valid {fromArea} ({fromYear}) codes:"
      ))
    } else {
      message(glue::glue(
        "\nThe following code was passed but is not a valid {fromArea} ({fromYear}) code:"
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
  }

  if (value_type == "aggs") {
    stopifnot(length(codes) == length(unique(codes)))

    mapped_df <-
      df |>
      dplyr::left_join(correspondence_tbl, by = c("codes" = names(correspondence_tbl)[1])) |>
      dplyr::mutate(values = values * ratio) |>
      dplyr::group_by(!!rlang::sym(names(correspondence_tbl)[3])) |>
      dplyr::summarize(values = sum(values)) |>
      (\(.data) if (round) dplyr::mutate(.data, values = round(values)) else .data)()
  }

  mapped_df
}


get_mapping_tbl_col_name <- function(area, year) {
  if(length(area) > 1) {
    col_names <- lapply(area, \(x) get_mapping_tbl_col_name(x, year))
    return(do.call("c", col_names))
  }

  if(is_SA(area)) {
    glue::glue("{clean_sa(area)}_code_{year}")
  } else {
    stop("Not sure how to make col names for non-SA areas yet...")
  }

}


get_asgs_table <- function(fromArea, toArea, year) {
  stopifnot(as.character(year) %in% c("2011", "2016", "2021"))

  valid_areas <- c("sa1", "sa2", "sa3", "sa4", "gcc")
  stopifnot(fromArea %in% valid_areas)
  stopifnot(toArea %in% valid_areas)
  stopifnot(which(valid_areas == fromArea) < which(valid_areas == toArea))

  cols <- glue::glue("{tolower(c(fromArea, toArea))}_code_{year}")

  get(paste0("asgs_", year)) |>
    dplyr::select(dplyr::all_of(cols)) |>
    dplyr::distinct()
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


#' @importFrom absmapsdata get_correspondence_absmaps
#' @export
absmapsdata::get_correspondence_absmaps
