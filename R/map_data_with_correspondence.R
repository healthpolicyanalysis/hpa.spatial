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
  call <- match.call.defaults()
  call$codes <- NULL
  call$values <- NULL
  call$value_type <- NULL
  call$round <- NULL

  call[[1]] <- as.name("get_correspondence_absmaps")
  correspondence_tbl <- eval(call, envir = parent.frame())

  value_type <- match.arg(value_type)
  stopifnot(length(codes) == length(values))

  # remove codes that aren't in the correspondence table
  bad_codes <- codes[!codes %in% dplyr::pull(correspondence_tbl, 1)]

  if (length(bad_codes) != 0) {
    message(glue::glue(
      "\nThe following codes were passed but are not valid {fromArea}({fromYear}) codes:"
    ))
    for (c in bad_codes) {
      message("\n")
      message(c)
    }
  }

  df <- data.frame(codes = as.character(codes), values) |>
    dplyr::filter(codes %in% dplyr::pull(correspondence_tbl, 1))


  if (value_type == "units") {
    # randomly assign codes to new mapped codes based on ratios
    f_assign_code <- function(code, mapping_df) {
      mapping_df_filtered <- mapping_df[mapping_df[, 1] == code, ]
      sample(dplyr::pull(mapping_df_filtered, 2), size = 1, prob = dplyr::pull(mapping_df_filtered, 3))
    }

    mapped_df <- df |>
      dplyr::rowwise() |>
      dplyr::mutate(codes = f_assign_code(code = codes, mapping_df = correspondence_tbl[, c(1, 3, 5)]))

    names(mapped_df)[1] <- names(correspondence_tbl)[3]
  }

  if (value_type == "aggs") {
    # dispers value
    stopifnot(length(codes) == length(unique(codes)))
    # browser()

    mapped_df <-
      df |>
      dplyr::left_join(correspondence_tbl, by = c("codes" = names(correspondence_tbl)[1])) |>
      dplyr::mutate(values = values * ratio) |>
      dplyr::select(dplyr::all_of(c(names(correspondence_tbl)[3], "values"))) |>
      (\(.data) if (round) dplyr::mutate(.data, values = round(values)) else .data)()
  }

  mapped_df
}


#' @importFrom absmapsdata get_correspondence_absmaps
#' @export
absmapsdata::get_correspondence_absmaps
