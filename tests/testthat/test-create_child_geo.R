# test_that("child remains unchanged when it should", {
#   sa2 <- get_polygon("sa22016")
#   sa3 <- get_polygon("sa32016")
#
#   expect_identical(
#     sa2,
#     suppressWarnings(create_child_geo(child_geo = sa2, parent_geo = sa3))
#   )
# })

test_that("SA3s are adapted when adapted to be within LHNs", {
  sa3 <- get_polygon("sa32016")
  lhns <- get_polygon("LHN")

  new_sa3s <- create_child_geo(sa3, lhns)

})
