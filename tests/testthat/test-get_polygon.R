test_that("get_polygon works", {
  sa2_16 <- get_polygon(area = "sa2", year = 2016)

  sa2_16_simplified <- get_polygon(area = "sa2", year = 2016, simplify_keep = 0.05)

  expect_s3_class(sa2_16, "sf")
  expect_s3_class(sa2_16_simplified, "sf")

  # simplified polygon should be smaller than original
  expect_lt(object.size(sa2_16_simplified), object.size(sa2_16))
})
