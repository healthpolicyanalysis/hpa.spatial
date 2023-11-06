test_that("child remains unchanged when it should", {
  sa2 <- get_polygon("sa22016")
  sa3 <- get_polygon("sa32016")

  expect_identical(
    sa2,
    suppressWarnings(create_child_geo(child_geo = sa2, parent_geo = sa3))
  )
})

test_that("SA3s are adapted when adapted to be within LHNs", {
  qld_sa3 <- get_polygon("sa32016") |>
    dplyr::filter(state_name_2016 == "Queensland")
  qld_lhns <- get_polygon("LHN") |>
    dplyr::filter(state == "QLD")
  qld_new_sa3s <- create_child_geo(qld_sa3, qld_lhns)


  qld_new_sa3s |>
    dplyr::filter(stringr::str_detect(sa3_code_2016, "-")) |>
    dplyr::pull(sa3_code_2016) |>
    sort() |>
    expect_snapshot()

  expect_gt(nrow(qld_new_sa3s), nrow(qld_sa3))
})
