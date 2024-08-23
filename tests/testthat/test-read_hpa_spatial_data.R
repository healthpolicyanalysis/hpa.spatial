test_that("downloading data from hpa.spatial.data works", {
  expect_s3_class(read_hpa_spatial_data("phn"), "sf") # test normal shapes
  expect_s3_class(read_hpa_spatial_data("mb21_poly"), "sf") # test partitioned shapes
})
