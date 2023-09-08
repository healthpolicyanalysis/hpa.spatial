test_that("get_polygon works", {
  sa2_16 <- suppressMessages(get_polygon(area = "sa2", year = 2016))

  sa2_16_simplified <- suppressMessages(get_polygon(area = "sa2", year = 2016, simplify_keep = 0.05))

  expect_s3_class(sa2_16, "sf")
  expect_s3_class(sa2_16_simplified, "sf")

  # simplified polygon should be smaller than original
  expect_lt(object.size(sa2_16_simplified), object.size(sa2_16))
})


test_that("get_polygon for internal data works", {
  for (geo in .get_internal_polygon_names()) {
    shp <- suppressMessages(get_polygon(area = geo))
    expect_s3_class(shp, "sf")
    shp <- suppressMessages(get_polygon(name = geo))
    expect_s3_class(shp, "sf")
  }
})

test_that("get_polygon messaging for bad names work", {
  suppressMessages(expect_error(
    get_polygon(name = "asdasd"),
    regexp = paste0(.get_internal_polygon_names(), collapse = ", ")
  ))
})


test_that("get_polygon works when called without hpa.spatial loaded", {
  p <- callr::r(function() hpa.spatial::get_polygon("sa22016"))
  expect_s3_class(p, "sf")

  p <- callr::r(function() hpa.spatial::get_polygon("LHN"))
  expect_s3_class(p, "sf")
})
