test_that("test mapping is similar to published correspondence tables", {
  sa2_2016_wb <- get_polygon("sa22016", crs = 7844) |>
    dplyr::filter(sa4_name_2016 == "Brisbane - West")

  sa2_2021_wb <- get_polygon("sa22021", crs = 7844) |>
    dplyr::filter(sa4_name_2021 == "Brisbane - West")

  published_tbl <- strayr::read_correspondence_tbl("sa2", 2016, "sa2", "2021.csv")

  tbl_ref <- published_tbl |>
    dplyr::filter(SA2_MAINCODE_2016 %in% sa2_2016_wb$sa2_code_2016) |>
    dplyr::select(SA2_MAINCODE_2016, SA2_CODE_2021, ratio) |>
    dplyr::arrange(SA2_MAINCODE_2016, SA2_CODE_2021) |>
    dplyr::mutate(dplyr::across(!ratio, as.character))

  wb_mb21 <- readRDS(test_path("fixtures/brisbane_west_mb.rds"))$pop

  tbl_test <- make_correspondence_tbl(from_geo = sa2_2016_wb, sa2_2021_wb, mb_geo = wb_mb21)

  names(tbl_test) <- names(tbl_ref)

  expect_identical(tbl_ref, tbl_test)
})


test_that("test mapping works for non-standard geographies", {
  to_lhn <- get_polygon(area = "LHN", crs = 7844)

  from_sa3_2016_wb <- get_polygon("sa32016", crs = 7844) |>
    dplyr::filter(sa4_name_2016 == "Brisbane - West")

  wb_mb21 <- readRDS(test_path("fixtures/brisbane_west_mb.rds"))$pop

  # test creation of correspondence table on non-standard geography
  wb_sa3_to_lhn_tbl <- make_correspondence_tbl(from_sa3_2016_wb, to_lhn, mb_geo = wb_mb21)

  expect_tbl_snap(wb_sa3_to_lhn_tbl)
})
