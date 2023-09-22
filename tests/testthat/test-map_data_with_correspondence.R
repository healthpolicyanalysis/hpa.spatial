test_that("mapping using created correspondence tables when abs ones aren't available", {
  sa2_2021 <- suppressMessages(get_polygon(area = "sa2", year = 2021))
  withr::with_seed(
    42,
    {
      sa2_2021$test_outcome <- rnorm(nrow(sa2_2021))
    }
  )

  mapped_df_with_data <- suppressWarnings(map_data_with_correspondence(
    codes = sa2_2021$sa2_code_2021,
    values = sa2_2021$test_outcome,
    from_area = "sa2",
    from_year = 2021,
    to_area = "LHN",
    value_type = "aggs"
  ))

  expect_s3_class(mapped_df_with_data, "tbl")
  expect_snapshot(mapped_df_with_data)
})

test_that("passing dataframe and retaining column names works", {
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))
  withr::with_seed(
    42,
    {
      sa2_2011_sample <- sa2_2011[1:100,]

      sa2_2011_sample_with_groups <-
        lapply(
          LETTERS[1:5],
          \(x)tibble::add_column(.data = sa2_2011_sample, letter_group = x)
        ) |>
        (\(x) do.call("rbind", x))()

      sa2_2011_sample_with_groups$test_outcome <- rnorm(nrow(sa2_2011_sample_with_groups))
    }
  )

  mapped_df_with_data <- map_data_with_correspondence(
    sa2_2011_sample_with_groups,
    codes = sa2_code_2011,
    values = test_outcome,
    groups = letter_group,
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2011,
    value_type = "aggs"
  )

  mapped_df_without_data <- map_data_with_correspondence(
    codes = sa2_2011_sample_with_groups$sa2_code_2011,
    values = sa2_2011_sample_with_groups$test_outcome,
    groups = sa2_2011_sample_with_groups$letter_group,
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2011,
    value_type = "aggs"
  )
  expect_equal(names(mapped_df_with_data), c("sa3_code_2011", "test_outcome", "letter_group"))
  expect_equal(
    unname(as.matrix(mapped_df_with_data)),
    unname(as.matrix(mapped_df_without_data))
  )
})


test_that("grouping works", {
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))

  n_sample <- 200
  withr::with_seed(
    42,
    {
      sa2_to_sa3_2011_mapped_grped_aggs <- map_data_with_correspondence(
        codes = sample(sa2_2011$sa2_code_2011, size = n_sample),
        values = rnorm(n = n_sample),
        groups = sample(LETTERS[1:5], size = n_sample, replace = TRUE),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa3",
        to_year = 2011,
        value_type = "aggs"
      )
    }
  )
  expect_snapshot(sa2_to_sa3_2011_mapped_grped_aggs)
})


test_that("aggregating up SA's works", {
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))


  n_sample <- 200
  withr::with_seed(
    42,
    {
      sa2_to_sa3_2011_mapped_unit <- map_data_with_correspondence(
        codes = sample(sa2_2011$sa2_code_2011, size = n_sample),
        values = rnorm(n = n_sample),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa3",
        to_year = 2011
      )

      sa2_to_sa3_2011_mapped_aggs <- map_data_with_correspondence(
        codes = sample(sa2_2011$sa2_code_2011, size = n_sample),
        values = rnorm(n = n_sample),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa3",
        to_year = 2011,
        value_type = "aggs"
      )
    }
  )

  expect_snapshot(sa2_to_sa3_2011_mapped_unit)
  expect_snapshot(sa2_to_sa3_2011_mapped_aggs)
  expect_lt(nrow(sa2_to_sa3_2011_mapped_aggs), nrow(sa2_to_sa3_2011_mapped_unit))
})


test_that("mapping across SAs and editions together works", {
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))

  withr::with_seed(
    42,
    {
      n_sample <- 200
      sa2_2011_sample <- dplyr::sample_n(sa2_2011, n_sample)
      random_vals <- rnorm(n = n_sample)
      sample_codes <- sample(sa2_2011$sa2_code_2011, size = n_sample)
    }
  )

  sa2_to_sa3_2011_to_2016_mapped_unit_ref_col <- map_data_with_correspondence(
    .data = sa2_2011_sample,
    codes = sa2_code_2011,
    values = random_vals,
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2016,
    seed = 42
  )

  sa2_to_sa3_2011_to_2016_mapped_unit <- map_data_with_correspondence(
    codes = sample_codes,
    values = random_vals,
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2016,
    seed = 42
  )


  sa2_to_sa3_2011_to_2016_mapped_aggs <- map_data_with_correspondence(
    codes = sample_codes,
    values = random_vals,
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2016,
    value_type = "aggs"
  )
  expect_snapshot(sa2_to_sa3_2011_to_2016_mapped_unit_ref_col)
  expect_snapshot(sa2_to_sa3_2011_to_2016_mapped_unit)
  expect_snapshot(sa2_to_sa3_2011_to_2016_mapped_aggs)
  expect_lt(
    nrow(sa2_to_sa3_2011_to_2016_mapped_aggs),
    nrow(sa2_to_sa3_2011_to_2016_mapped_unit)
  )

  expect_true(all(
    sa2_to_sa3_2011_to_2016_mapped_unit_ref_col$sa3_code_2016 %in% asgs_2016$sa3_code_2016
  ))

  expect_true(all(
    sa2_to_sa3_2011_to_2016_mapped_unit$sa3_code_2016 %in% asgs_2016$sa3_code_2016
  ))

  expect_true(all(
    sa2_to_sa3_2011_to_2016_mapped_aggs$sa3_code_2016 %in% asgs_2016$sa3_code_2016
  ))
})


test_that("mapping data works", {
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))

  withr::with_seed(
    42,
    sa2_2016_mapped_unit <- map_data_with_correspondence(
      codes = sa2_2011$sa2_code_2011,
      values = rnorm(n = nrow(sa2_2011)),
      from_area = "sa2",
      from_year = 2011,
      to_area = "sa2",
      to_year = 2016
    )
  )

  expect_snapshot(sa2_2016_mapped_unit)

  # expect that some SA2s will have multiple units mapped to them (not a 1-to-1
  # relationship when mapping on unit level
  expect_gt(nrow(sa2_2016_mapped_unit), length(unique(sa2_2016_mapped_unit$SA2_MAINCODE_2016)))


  withr::with_seed(
    42,
    sa2_2016_mapped_aggs <- map_data_with_correspondence(
      codes = sa2_2011$sa2_code_2011,
      values = rpois(n = nrow(sa2_2011), lambda = 15),
      from_area = "sa2",
      from_year = 2011,
      to_area = "sa2",
      to_year = 2016,
      value_type = "aggs"
    )
  )
  expect_snapshot(sa2_2016_mapped_aggs)
  # expect that all SA2s will only a single value (1-to-1 relationship when
  # mapping on aggregate level as the mapped values should be summed within new
  # location codes)
  expect_equal(
    length(unique(sa2_2016_mapped_aggs$SA2_MAINCODE_2016)),
    nrow(sa2_2016_mapped_aggs)
  )

  mdf <- suppressMessages(map_data_with_correspondence(
    codes = c(107011130, 107041548, 234234, 234234, 234234),
    values = c(10, 10, 1, 1, 1),
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa2",
    to_year = 2016
  ))

  # should have removed bad codes
  expect_equal(nrow(mdf), 1)


  # should see message with bad code(s)
  ## singular
  suppressMessages(
    expect_message(
      map_data_with_correspondence(
        codes = c(107011130, 107041548),
        values = c(10, 10),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa2",
        to_year = 2016
      ),
      "not a valid"
    )
  )

  ## plural
  suppressMessages(
    expect_message(
      map_data_with_correspondence(
        codes = c(107011130, 107041548, 234239874),
        values = c(10, 10, 1),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa2",
        to_year = 2016
      ),
      "not valid"
    )
  )


  withr::with_seed(
    42,
    mdf_agg <- map_data_with_correspondence(
      codes = c(107011130, 107041149),
      values = c(10, 10),
      from_area = "sa2",
      from_year = 2011,
      to_area = "sa2",
      to_year = 2016,
      value_type = "aggs"
    )
  )
  expect_snapshot_output(mdf_agg)

  withr::with_seed(
    123,
    mdf_agg_rounded <- map_data_with_correspondence(
      codes = c(107011130, 107041149),
      values = c(10, 10),
      from_area = "sa2",
      from_year = 2011,
      to_area = "sa2",
      to_year = 2016,
      value_type = "aggs",
      round = TRUE
    )
  )
  expect_snapshot_output(mdf_agg_rounded)
})
