test_that("child remains unchanged when it should", {
  sa2 <- get_polygon("sa22016")
  sa3 <- get_polygon("sa32016")

  expect_identical(
    sa2,
    suppressWarnings(create_child_geo(child_geo = sa2, parent_geo = sa3))
  )
})

test_that("SA3s are adapted when adapted to be within LHNs", {
  sa3 <- get_polygon("sa32016")
  lhns <- get_polygon("LHN")
  new_sa3s <- create_child_geo(sa3, lhns)

  gg <- cowplot::plot_grid(
    ggplot2::ggplot() +
      ggplot2::geom_sf(data = new_sa3s),
    ggplot2::ggplot() +
      ggplot2::geom_sf(data = sa3),
    ggplot2::ggplot() +
      ggplot2::geom_sf(data = lhns),
    labels = c("new-sa3s", "old-sa3s", "lhns")
  )

  vdiffr::expect_doppelganger(
    "adjusted_SA3s_within_LHNs",
    gg
  )
})
