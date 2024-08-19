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


test_that("can get a custom CG via make_correspondence_tbl()", {
  tbl <- suppressWarnings(get_correspondence_tbl(from_area = "sa2", from_year = 2011, to_area = "LHN"))

  expect_tbl_snap(tbl)
})

test_that("can get CG using input polygons rather than areas/years", {
  from_sa2 <- suppressWarnings(get_polygon(name = "sa32016", crs = 7844))
  to_lhn <- get_polygon(name = "LHN")

  tbl <- get_correspondence_tbl(
    from_geo = from_sa2,
    to_geo = to_lhn,
    export_fname = "sa2-to-lhn"
  )

  expect_tbl_snap(tbl)
})

test_that("correspondence table is complete - all non-NA SA2 mappings are other territories", {
  tbl <- suppressWarnings(get_correspondence_tbl(from_area = "sa2", from_year = 2021, to_area = "LHN")) |>
    dplyr::filter(is.na(LHN_Name))

  expect_tbl_snap(tbl)
})
