.map_data_with_ct <- function(codes,
                              values,
                              correspondence_tbl,
                              value_type,
                              bad_codes,
                              round_values,
                              seed,
                              split_map = NULL) {
  assertthat::assert_that(assertthat::are_equal(length(codes), length(values)))
  assertthat::assert_that(assertthat::is.flag(round_values))
  df <- dplyr::tibble(codes = codes, values = values)
  if (value_type == "units") {
    # callers looping over groups with the same correspondence_tbl can build
    # this once and pass it in, rather than rebuilding it per group
    if (is.null(split_map)) {
      split_map <- build_split_map(correspondence_tbl)
    }

    # randomly assign codes to new mapped codes based on ratios
    f_assign_code <- function(code, split_map) {
      mapping_df_filtered <- split_map[[as.character(code)]]
      sample(mapping_df_filtered[[2]], size = 1, prob = mapping_df_filtered[[3]])
    }

    if (is.null(seed)) {
      mapped_df <- df |>
        dplyr::rowwise() |>
        dplyr::mutate(codes = f_assign_code(code = codes, split_map = split_map))
    } else {
      withr::with_seed(seed, {
        mapped_df <- df |>
          dplyr::rowwise() |>
          dplyr::mutate(codes = f_assign_code(code = codes, split_map = split_map))
      })
    }

    names(mapped_df)[1] <- names(correspondence_tbl)[2]

    stopifnot(nrow(mapped_df) == length(values[!codes %in% bad_codes]))
  }

  if (value_type == "aggs") {
    stopifnot(length(codes) == length(unique(codes)))

    mapped_df <- df |>
      dplyr::left_join(correspondence_tbl, by = c("codes" = names(correspondence_tbl)[1])) |>
      dplyr::mutate(values = values * ratio) |>
      dplyr::group_by(!!rlang::sym(names(correspondence_tbl)[2])) |>
      dplyr::summarize(values = sum(values))
  }

  stopifnot(all.equal(sum(mapped_df$values), sum(values[!codes %in% bad_codes])))

  if (value_type == "aggs" & round_values) {
    mapped_df <- dplyr::mutate(mapped_df, values = round(values))
  }

  mapped_df
}


# pre-fill NA ratios once per from-code and split into a lookup keyed by
# code, so each row assignment is an O(1) lookup instead of a full-table filter
build_split_map <- function(correspondence_tbl) {
  code_col <- names(correspondence_tbl)[1]
  correspondence_tbl |>
    dplyr::group_by(!!rlang::sym(code_col)) |>
    dplyr::mutate(
      ratio = {
        na_idx <- is.na(ratio)
        if (any(na_idx)) {
          ratio[na_idx] <- (1 - sum(ratio, na.rm = TRUE)) / sum(na_idx)
        }
        ratio
      }
    ) |>
    dplyr::ungroup() |>
    (\(x) split(x, x[[code_col]]))()
}
