test_that("test mapping is similar to published correspondence tables", {
  sa2_2016 <- suppressWarnings(get_polygon("sa22016", crs = 7844))
  sa2_2016_qld <- sa2_2016[sa2_2016$state_name_2016 == "Queensland", ]
  sa2_2021 <- suppressWarnings(get_polygon("sa22021", crs = 7844))
  sa2_2021_qld <- sa2_2021[sa2_2021$state_name_2021 == "Queensland", ]

  published_tbl <- strayr::read_correspondence_tbl("sa2", 2016, "sa2", "2021.csv")

  tbl_ref <- withr::with_package("dplyr", {
    published_tbl |>
      filter(SA2_MAINCODE_2016 %in% sa2_2016_qld$sa2_code_2016) |>
      select(SA2_MAINCODE_2016, SA2_CODE_2021, ratio) |>
      arrange(SA2_MAINCODE_2016, SA2_CODE_2021) |>
      mutate(across(!ratio, as.character))
  })

  qld_mb21 <- mb21_pop |>
    dplyr::filter(STE_NAME21 == "Queensland")

  tbl_test <- make_correspondence_tbl(from_geo = sa2_2016_qld, sa2_2021_qld, mb_geo = qld_mb21)

  # TODO: come up with a good test of approx. equivalence to the correspondence files from abs...
  dplyr::full_join(
    tbl_ref,
    tbl_test,
    by = c("SA2_MAINCODE_2016" = "sa2_code_2016", "SA2_CODE_2021" = "sa2_code_2021")
  ) |>
    dplyr::filter(ratio.x != ratio.y)

  expect_snapshot(tbl_test)
})
