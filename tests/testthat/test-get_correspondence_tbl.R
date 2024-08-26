test_that("can get CG from absmapsdata", {
  tbl <- get_correspondence_tbl(
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa2",
    to_year = 2016
  )
  expect_tbl_snap(tbl)
})

test_that("can get CG via make_correspondence_tbl() and retrieve faster a second time", {
  res <- callr::r(function() {
    t1 <- Sys.time()
    tbl <- hpa.spatial::get_correspondence_tbl(from_area = "sa2", from_year = 2011, to_area = "sa2", to_year = 2016)
    t2 <- Sys.time()

    first_call <- t2 - t1

    t1 <- Sys.time()
    hpa.spatial::get_correspondence_tbl(from_area = "sa2", from_year = 2011, to_area = "sa2", to_year = 2016)
    t2 <- Sys.time()

    second_call <- t2 - t1

    return(list(tbl = tbl, first_call = first_call, second_call = second_call))
  })

  expect_lt(res$second_call, res$first_call) # second retrieval should be faster than first
})

test_that("can get CG using input polygons rather than areas/years and using a custom CG", {
  test_mb <- readRDS(test_path("fixtures", "brisbane_west_mb.rds"))

  from_sa3 <- suppressWarnings(get_polygon(name = "sa32016", crs = 7844)) |>
    dplyr::filter(sa4_name_2016 == "Brisbane - West")

  to_lhn <- get_polygon(name = "LHN")

  tbl <- get_correspondence_tbl(
    from_geo = from_sa3,
    to_geo = to_lhn,
    export_fname = "sa2-to-lhn",
    mb_geo = test_mb$pop
  )

  expect_tbl_snap(tbl)
})
