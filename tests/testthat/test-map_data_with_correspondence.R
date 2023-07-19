test_that("multiplication works", {
  mdf <- suppressMessages(map_data_with_correspondence(
    codes = c(107011130, 107041548),
    values = c(10, 10),
    fromArea = "sa2",
    fromYear = 2011,
    toArea = "sa2",
    toYear = 2016
  ))

  # should have removed bad code
  expect_equal(nrow(mdf), 1)


  # should see message with bad code
  suppressMessages(
    expect_message(
      map_data_with_correspondence(
        codes = c(107011130, 107041548),
        values = c(10, 10),
        fromArea = "sa2",
        fromYear = 2011,
        toArea = "sa2",
        toYear = 2016
      ),
      "not valid sa2"
    )
  )


  withr::with_seed(
    42,
    mdf_agg <- map_data_with_correspondence(
      codes = c(107011130, 107041149),
      values = c(10, 10),
      fromArea = "sa2",
      fromYear = 2011,
      toArea = "sa2",
      toYear = 2016,
      value_type = "aggs"
    )
  )
  expect_snapshot_output(mdf_agg)

  withr::with_seed(
    123,
    mdf_agg_rounded <- map_data_with_correspondence(
      codes = c(107011130, 107041149),
      values = c(10, 10),
      fromArea = "sa2",
      fromYear = 2011,
      toArea = "sa2",
      toYear = 2016,
      value_type = "aggs",
      round = TRUE
    )
  )
  expect_snapshot_output(mdf_agg_rounded)
})
