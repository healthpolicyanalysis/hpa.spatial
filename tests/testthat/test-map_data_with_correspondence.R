test_that("custom correspondence table work", {
  d_nsw_postcodes <- get_polygon("postcode2021") |>
    dplyr::filter(substr(postcode_2021, 1, 1) == "2")

  d_nsw_postcodes$vals <- rnorm(n = nrow(d_nsw_postcodes))

  custom_ct <- get_correspondence_tbl(
    from_area = "postcode", from_year = 2021,
    to_area = "SA3", to_year = 2021
  ) |>
    dplyr::filter(substr(sa3_code_2021, 1, 1) == "1") # only keep those that map to NSW SA3's

  mapped_data <- map_data_with_correspondence(
    .data = d_nsw_postcodes,
    codes = postcode_2021,
    values = vals,
    correspondence_tbl = custom_ct,
    value_type = "aggs",
    quiet = TRUE
  )
  unique_states_n <- nrow(dplyr::count(mapped_data, substr(sa3_code_2021, 1, 1)))
  expect_true(unique_states_n == 1)
})


test_that("problem case from unmet needs is fixed", {
  sa22016 <- get_polygon("sa22016") |>
    remove_empty_geographies()

  obj <- readRDS(test_path("fixtures", "test-data-sa22016-to-sa22021.rds")) |>
    dplyr::filter(SA2Cd2016 %in% sa22016$sa2_code_2016)

  mapped_data <- map_data_with_correspondence(
    .data = obj,
    codes = SA2Cd2016,
    values = PrtcpntCnt,
    groups = ReportDte,
    from_area = "sa2",
    from_year = 2016,
    to_area = "sa2",
    to_year = "2021.csv",
    value_type = "aggs"
  )

  expect_snapshot(mapped_data)
})


test_that("using multiple groups works", {
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))
  withr::with_seed(
    42,
    {
      n_sample <- 100
      sa2_2011_sample_with_groups <- sa2_2011[1:n_sample, ] |>
        (\(x) {
          x$g1 <- sample(LETTERS[1:5], size = n_sample, replace = TRUE)
          x$g2 <- sample(letters[1:5], size = n_sample, replace = TRUE)
          x$test_outcome <- rnorm(n_sample)
          return(x)
        })()
    }
  )

  mapped_df_with_data1 <- map_data_with_correspondence(
    sa2_2011_sample_with_groups,
    codes = sa2_code_2011,
    values = "test_outcome",
    groups = list(sa2_2011_sample_with_groups$g1, sa2_2011_sample_with_groups$g2),
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2011,
    value_type = "aggs"
  )

  mapped_df_with_data2 <- map_data_with_correspondence(
    sa2_2011_sample_with_groups,
    codes = sa2_code_2011,
    values = test_outcome,
    groups = c(g1, g2),
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2011,
    value_type = "aggs"
  )

  mapped_df_with_data3 <- map_data_with_correspondence(
    codes = sa2_2011_sample_with_groups$sa2_code_2011,
    values = sa2_2011_sample_with_groups$test_outcome,
    groups = list(sa2_2011_sample_with_groups$g1, sa2_2011_sample_with_groups$g2),
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2011,
    value_type = "aggs"
  )


  expect_snapshot(mapped_df_with_data1)
  expect_snapshot(mapped_df_with_data2)
  expect_identical(
    unname(as.matrix(mapped_df_with_data1)),
    unname(as.matrix(mapped_df_with_data2))
  )

  expect_identical(
    unname(as.matrix(mapped_df_with_data2)),
    unname(as.matrix(mapped_df_with_data3))
  )
})


test_that("mapping using user-provided polygons", {
  from_sa2s <- suppressMessages(get_polygon("sa22016")) |>
    remove_empty_geographies()
  to_lhns <- suppressMessages(get_polygon("LHN"))
  withr::with_seed(
    42,
    {
      from_sa2s$test_outcome <- rnorm(nrow(from_sa2s))
    }
  )

  mapped_df_with_data <- suppressWarnings(map_data_with_correspondence(
    codes = from_sa2s[[1]],
    values = from_sa2s$test_outcome,
    from_geo = from_sa2s,
    to_geo = to_lhns,
    export_fname = "sa22016_to_lhns",
    value_type = "aggs"
  ))

  expect_s3_class(mapped_df_with_data, "tbl")
  expect_snapshot(mapped_df_with_data)

  mapped_df_with_data2 <- callr::r(function() {
    from_sa2s <- suppressMessages(hpa.spatial::get_polygon("sa22016")) |>
      hpa.spatial:::remove_empty_geographies()
    to_lhns <- suppressMessages(hpa.spatial::get_polygon("LHN"))
    withr::with_seed(
      42,
      {
        from_sa2s$test_outcome <- rnorm(nrow(from_sa2s))
      }
    )

    suppressWarnings(hpa.spatial::map_data_with_correspondence(
      codes = from_sa2s[[1]],
      values = from_sa2s$test_outcome,
      from_geo = from_sa2s,
      to_geo = to_lhns,
      export_fname = "sa22016_to_lhns",
      value_type = "aggs"
    ))
  })

  expect_identical(mapped_df_with_data, mapped_df_with_data2)
})


test_that("test mapping with custom geo", {
  sa3 <- suppressWarnings(get_polygon("sa32016", crs = 7844))
  lhns <- get_polygon("LHN")
  new_sa3s <- create_child_geo(sa3, lhns)

  mapped_data <- map_data_with_correspondence(
    codes = new_sa3s[[1]],
    values = withr::with_seed(42, rnorm(n = nrow(new_sa3s))),
    from_geo = new_sa3s[1],
    to_geo = lhns,
    value_type = "aggs",
    export_fname = "adjusted-sa3s-to-lhns"
  )

  expect_snapshot(mapped_data)
})

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

  mapped_df_with_data2 <- callr::r(function() {
    sa2_2021 <- suppressMessages(hpa.spatial::get_polygon(area = "sa2", year = 2021))
    withr::with_seed(
      42,
      {
        sa2_2021$test_outcome <- rnorm(nrow(sa2_2021))
      }
    )

    suppressWarnings(hpa.spatial::map_data_with_correspondence(
      codes = sa2_2021$sa2_code_2021,
      values = sa2_2021$test_outcome,
      from_area = "sa2",
      from_year = 2021,
      to_area = "LHN",
      value_type = "aggs"
    ))
  })

  expect_identical(mapped_df_with_data, mapped_df_with_data2)
})

test_that("passing dataframe and retaining column names works", {
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))
  withr::with_seed(
    42,
    {
      sa2_2011_sample <- sa2_2011[1:100, ]

      sa2_2011_sample_with_groups <-
        lapply(
          LETTERS[1:5],
          \(x)tibble::add_column(.data = sa2_2011_sample, letter_group = x)
        ) |>
        (\(x) do.call("rbind", x))()

      sa2_2011_sample_with_groups$test_outcome <- rnorm(nrow(sa2_2011_sample_with_groups))
    }
  )

  mapped_df_with_data1 <- map_data_with_correspondence(
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

  mapped_df_with_data2 <- map_data_with_correspondence(
    sa2_2011_sample_with_groups,
    codes = sa2_code_2011,
    values = "test_outcome",
    groups = sa2_2011_sample_with_groups$letter_group,
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

  expect_equal(names(mapped_df_with_data1), c("sa3_code_2011", "test_outcome", "letter_group"))
  expect_equal(
    unname(as.matrix(mapped_df_with_data1)),
    unname(as.matrix(mapped_df_without_data))
  )
  expect_equal(
    unname(as.matrix(mapped_df_with_data1)),
    unname(as.matrix(mapped_df_with_data2))
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
    }
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
      "107041548"
    )
  )

  expect_no_message(
    map_data_with_correspondence(
      codes = c(107011130, 107041548),
      values = c(10, 10),
      from_area = "sa2",
      from_year = 2011,
      to_area = "sa2",
      to_year = 2016,
      quiet = TRUE
    )
  )

  expect_no_message(
    withr::with_options(
      list(hpa.spatial.quiet = TRUE),
      map_data_with_correspondence(
        codes = c(107011130, 107041548),
        values = c(10, 10),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa2",
        to_year = 2016
      )
    )
  )

  expect_message(
    withr::with_options(
      list(hpa.spatial.quiet = FALSE),
      map_data_with_correspondence(
        codes = c(107011130, 107041548),
        values = c(10, 10),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa2",
        to_year = 2016
      )
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
