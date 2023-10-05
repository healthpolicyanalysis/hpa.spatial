test_that("downloading data from hpa.spatial.data works", {
  read_hpa_spatial_data("phn")
  read_hpa_spatial_data("lhn")
  read_hpa_spatial_data("mb21_poly")
})
