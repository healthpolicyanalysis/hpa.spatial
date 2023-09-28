test_that("can get CG from absmapsdata", {
  tbl <- get_correspondence_tbl(
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa2",
    to_year = 2016
  )
  expect_snapshot(tbl)
})

test_that("can get CG via make_correspondence_tbl() and retrieve faster a second time", {
  res <- callr::r(function() {
    t1 <- Sys.time()
    tbl <- hpa.spatial::get_correspondence_tbl(from_area = "sa2", from_year = 2011, to_area = "LHN")
    t2 <- Sys.time()

    first_call <- t2 - t1

    t1 <- Sys.time()
    hpa.spatial::get_correspondence_tbl(from_area = "sa2", from_year = 2011, to_area = "LHN")
    t2 <- Sys.time()

    second_call <- t2 - t1

    return(list(tbl = tbl, first_call = first_call, second_call = second_call))
  })

  expect_lt(res$second_call, res$first_call) # second retrieval should be faster than first

  expect_snapshot(res$tbl)
})
