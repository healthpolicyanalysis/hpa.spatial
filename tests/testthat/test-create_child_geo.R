test_that("contained SA3s are unchanged, split SA3s are adapted", {
  suppressWarnings(withr::local_package("sf"))
  test_mb <- readRDS(test_path("fixtures", "brisbane_west_mb.rds"))

  qld_sa3 <- get_polygon("sa32021") |>
    dplyr::filter(sa3_code_2021 %in% c("30402", "30403"))

  qld_lhns <- get_polygon("LHN") |>
    dplyr::filter(state == "QLD")

  qld_new_sa3s <- suppressWarnings(
    create_child_geo(
      child_geo = qld_sa3,
      parent_geo = qld_lhns,
      mb_geo = test_mb$pop,
      mb_poly = test_mb$poly
    )
  ) |>
    dplyr::as_tibble() |>
    dplyr::select(-geometry)

  split_geo <- qld_new_sa3s |>
    dplyr::filter(stringr::str_detect(sa3_code_2021, "30403"))

  contained_geo <- qld_new_sa3s |>
    dplyr::filter(stringr::str_detect(sa3_code_2021, "30402"))

  # the split geography should have multiple rows and the contained remains as 1
  expect_gt(nrow(split_geo), nrow(contained_geo))

  expect_snapshot(qld_new_sa3s)
})
