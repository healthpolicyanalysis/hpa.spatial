.map_data_with_ct <- function(codes,
                              values,
                              correspondence_tbl,
                              value_type,
                              bad_codes,
                              round_values,
                              seed) {
  assertthat::assert_that(assertthat::are_equal(length(codes), length(values)))
  assertthat::assert_that(assertthat::is.flag(round_values))
  df <- dplyr::tibble(codes = codes, values = values)
  if (value_type == "units") {
    # randomly assign codes to new mapped codes based on ratios
    f_assign_code <- function(code, mapping_df) {
      mapping_df_filtered <- dplyr::filter(mapping_df, mapping_df[[1]] == code)

      if (any(is.na(mapping_df_filtered[[3]]))) {
        na_count <- sum(is.na(mapping_df_filtered[[3]]))
        sum_ratio <- sum(mapping_df_filtered[[3]], na.rm = TRUE)
        mapping_df_filtered[is.na(mapping_df_filtered[[3]]), 3] <- (1 - sum_ratio) / na_count
      }
      sample(mapping_df_filtered[[2]], size = 1, prob = mapping_df_filtered[[3]])
    }

    if (is.null(seed)) {
      mapped_df <- df |>
        dplyr::rowwise() |>
        dplyr::mutate(codes = f_assign_code(code = codes, mapping_df = correspondence_tbl))
    } else {
      withr::with_seed(seed, {
        mapped_df <- df |>
          dplyr::rowwise() |>
          dplyr::mutate(codes = f_assign_code(code = codes, mapping_df = correspondence_tbl))
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
