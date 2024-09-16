test_that("get_polygon works", {
  sa4_16 <- get_polygon(area = "sa4", year = 2016)

  sa4_16_simplified <- get_polygon(area = "sa4", year = 2016, simplify_keep = 0.05)

  expect_s3_class(sa4_16, "sf")
  expect_s3_class(sa4_16_simplified, "sf")

  # simplified polygon should be smaller than original
  expect_lt(object.size(sa4_16_simplified), object.size(sa4_16))
})

test_that("get_polygon for internal data works", {
  internal_names <- .get_internal_polygon_names()
  geo <- sample(internal_names[internal_names != "MB21"], size = 1)

  shp <- get_polygon(area = geo)
  expect_s3_class(shp, "sf")
  shp <- get_polygon(name = geo)
  expect_s3_class(shp, "sf")
})

test_that("get_polygon messaging for bad names work", {
  suppressMessages(expect_error(
    get_polygon(name = "asdasd"),
    regexp = paste0(.get_internal_polygon_names(), collapse = ", ")
  ))
})

test_that("get_polygon works when called without hpa.spatial loaded", {
  p <- callr::r(function() lapply(c("sa42016", "LHN"), hpa.spatial::get_polygon))
  for (i in seq_along(c("sa42016", "LHN"))) {
    expect_s3_class(p[[i]], "sf")
  }
})
