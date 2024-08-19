expect_tbl_snap <- function(x, sample_n = 100, seed = 42) {
  # this function is only ever used within the testing suite
  withr::local_seed(seed)

  x <- x |>
    dplyr::mutate(dplyr::across(
      dplyr::where(is.numeric),
      ~ round(.x, digits = 4)
    ))

  df_sample <- x |>
    dplyr::slice_sample(n = sample_n) |>
    as.data.frame()

  # check more of the data than just the head (as is done by `expect_snapshot(tibble)`)
  expect_snapshot(df_sample)

  # check the original data (checks that dimensions are still the same)
  expect_snapshot(x)
}
