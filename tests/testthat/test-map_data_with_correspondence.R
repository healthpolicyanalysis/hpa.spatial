test_that("user-specified correspondence table", {
  wb_shapes <- load_wb_sa3_and_hhs_mapping_shapes()
  wb_shapes$wb_sa32016$vals <- rep(1, nrow(wb_shapes$wb_sa32016))

  custom_ct <- get_correspondence_tbl(
    from_geo = wb_shapes$wb_sa32016,
    to_geo = wb_shapes$qld_lhn,
    mb_geo = wb_shapes$wb_mb21_pop,
    export_fname = "test-wb_sa32016-to-qld-hhs"
  )

  mapped_data <- map_data_with_correspondence(
    .data = wb_shapes$wb_sa32016,
    codes = sa3_code_2016,
    values = vals,
    correspondence_tbl = custom_ct,
    value_type = "aggs"
  )

  expect_equal(sum(wb_shapes$wb_sa32016$vals), sum(mapped_data$vals))
  expect_in(mapped_data$LHN_Name, wb_shapes$qld_lhn$LHN_Name)

  mapped_data2 <- callr::r(function() {
    wb_mb21_pop <- readRDS(testthat::test_path("fixtures/brisbane_west_mb.rds"))$pop

    wb_sa32016 <- suppressMessages(hpa.spatial::get_polygon(name = "sa32016", crs = 7844)) |>
      dplyr::filter(sa4_name_2016 == "Brisbane - West")

    qld_lhn <- suppressMessages(hpa.spatial::get_polygon(name = "LHN")) |>
      dplyr::filter(state == "QLD")


    wb_shapes <- list(
      wb_mb21_pop = wb_mb21_pop,
      wb_sa32016 = wb_sa32016,
      qld_lhn = qld_lhn
    )

    wb_shapes$wb_sa32016$vals <- rep(1, nrow(wb_shapes$wb_sa32016))

    custom_ct <- hpa.spatial::get_correspondence_tbl(
      from_geo = wb_shapes$wb_sa32016,
      to_geo = wb_shapes$qld_lhn,
      mb_geo = wb_shapes$wb_mb21_pop,
      export_fname = "test-wb_sa32016-to-qld-hhs"
    )

    mapped_data <- hpa.spatial::map_data_with_correspondence(
      .data = wb_shapes$wb_sa32016,
      codes = sa3_code_2016,
      values = vals,
      correspondence_tbl = custom_ct,
      value_type = "aggs"
    )
    mapped_data
  })

  expect_tbl_snap(mapped_data2)
  expect_identical(mapped_data, mapped_data2)
})

test_that("multiple groups and various ways of specifying args", {
  # ALSO tests that the column names are retained in resulting tibble

  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))
  withr::local_seed(42)
  n_sample <- 100
  sa2_2011_sample_with_groups <- sa2_2011[1:n_sample, ] |>
    (\(x) {
      x$g1 <- sample(LETTERS[1:5], size = n_sample, replace = TRUE)
      x$g2 <- sample(letters[1:5], size = n_sample, replace = TRUE)
      x$test_outcome <- rnorm(n_sample)
      return(x)
    })()

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


  expect_tbl_snap(mapped_df_with_data1)
  expect_tbl_snap(mapped_df_with_data2)
  expect_identical(
    unname(as.matrix(mapped_df_with_data1)),
    unname(as.matrix(mapped_df_with_data2))
  )

  expect_identical(
    unname(as.matrix(mapped_df_with_data2)),
    unname(as.matrix(mapped_df_with_data3))
  )
})


test_that("user-specified polygons", {
  withr::local_seed(42)
  from_sa2s <- suppressMessages(get_polygon("sa22016")) |>
    remove_empty_geographies()
  to_lhns <- suppressMessages(get_polygon("LHN"))

  from_sa2s$test_outcome <- rnorm(nrow(from_sa2s))

  mapped_df_with_data <- map_data_with_correspondence(
    codes = from_sa2s[[1]],
    values = from_sa2s$test_outcome,
    from_geo = from_sa2s,
    to_geo = to_lhns,
    export_fname = "sa22016_to_lhns",
    value_type = "aggs"
  )

  expect_s3_class(mapped_df_with_data, "tbl")
  expect_tbl_snap(mapped_df_with_data)
})


test_that("mapping with non-standard geo and default creation of correspondence tbl", {
  withr::local_seed(42)
  wb_shapes <- load_wb_sa3_and_hhs_mapping_shapes()
  wb_shapes$wb_sa32016$vals <- rep(1, nrow(wb_shapes$wb_sa32016))

  mapped_data <- map_data_with_correspondence(
    codes = wb_shapes$wb_sa32016[[1]],
    values = wb_shapes$wb_sa32016$vals,
    from_geo = wb_shapes$wb_sa32016,
    to_geo = wb_shapes$qld_lhn,
    value_type = "aggs",
    export_fname = "wb-sa3s-to-lhns"
  )

  expect_tbl_snap(mapped_data)
})


test_that("aggregating up SA's works (without correspondence tbl)", {
  withr::local_seed(42)
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))
  n_sample <- 200

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

  expect_tbl_snap(sa2_to_sa3_2011_mapped_unit)
  expect_tbl_snap(sa2_to_sa3_2011_mapped_aggs)
  expect_lt(nrow(sa2_to_sa3_2011_mapped_aggs), nrow(sa2_to_sa3_2011_mapped_unit))
})

test_that("mapping across SAs and editions together works (without correspondence tbl)", {
  withr::local_seed(42)
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))
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

  sa2_to_sa3_2011_to_2016_mapped_aggs <- map_data_with_correspondence(
    codes = sample_codes,
    values = random_vals,
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa3",
    to_year = 2016,
    value_type = "aggs"
  )
  expect_tbl_snap(sa2_to_sa3_2011_to_2016_mapped_unit_ref_col)
  expect_tbl_snap(sa2_to_sa3_2011_to_2016_mapped_unit)
  expect_tbl_snap(sa2_to_sa3_2011_to_2016_mapped_aggs)
  expect_lt(
    nrow(sa2_to_sa3_2011_to_2016_mapped_aggs),
    nrow(sa2_to_sa3_2011_to_2016_mapped_unit)
  )

  expect_in(sa2_to_sa3_2011_to_2016_mapped_unit_ref_col$sa3_code_2016, asgs_2016$sa3_code_2016)
  expect_in(sa2_to_sa3_2011_to_2016_mapped_unit$sa3_code_2016, asgs_2016$sa3_code_2016)
  expect_in(sa2_to_sa3_2011_to_2016_mapped_aggs$sa3_code_2016, asgs_2016$sa3_code_2016)
})


test_that("basic tests of output dimensions", {
  withr::local_seed(42)
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))

  sa2_2016_mapped_unit <- map_data_with_correspondence(
    codes = sa2_2011$sa2_code_2011,
    values = rnorm(n = nrow(sa2_2011)),
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa2",
    to_year = 2016
  )

  expect_tbl_snap(sa2_2016_mapped_unit)

  # expect that some SA2s will have multiple units mapped to them (not a 1-to-1
  # relationship when mapping on unit level
  expect_gt(nrow(sa2_2016_mapped_unit), length(unique(sa2_2016_mapped_unit$SA2_MAINCODE_2016)))

  sa2_2016_mapped_aggs <- map_data_with_correspondence(
    codes = sa2_2011$sa2_code_2011,
    values = rpois(n = nrow(sa2_2011), lambda = 15),
    from_area = "sa2",
    from_year = 2011,
    to_area = "sa2",
    to_year = 2016,
    value_type = "aggs"
  )

  expect_tbl_snap(sa2_2016_mapped_aggs)
  # expect that all SA2s will only a single value (1-to-1 relationship when
  # mapping on aggregate level as the mapped values should be summed within new
  # location codes)
  expect_equal(
    length(unique(sa2_2016_mapped_aggs$SA2_MAINCODE_2016)),
    nrow(sa2_2016_mapped_aggs)
  )
})

test_that("rounding works", {
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

  expect_identical(mdf_agg_rounded$values, round(mdf_agg_rounded$values))
})

test_that("messaging back to user", {
  withr::local_seed(42)
  sa2_2011 <- suppressMessages(get_polygon(area = "sa2", year = 2011))

  suppressMessages(
    expect_message(
      mdf_with_removed_codes <- map_data_with_correspondence(
        codes = c(107011130, 234234, 234234, 234234, 234234),
        values = c(10, 10, 1, 1, 1),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa2",
        to_year = 2016
      ),
      "234234"
    )
  )
  # should have removed bad codes
  expect_equal(nrow(mdf_with_removed_codes), 1)

  expect_no_message(
    # message should be removed with `quiet` arg
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
    # message should be removed with `quiet` option
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

  ## plural
  suppressMessages(
    expect_message(
      map_data_with_correspondence(
        codes = c(107011130, 107041548, 234239874),
        values = c(10, 10, 1),
        from_area = "sa2",
        from_year = 2011,
        to_area = "sa2",
        to_year = 2016,
        quiet = FALSE
      ),
      "not valid"
    )
  )
})
