if (FALSE) {
  brisbane_west_mb <- list(
    poly = dplyr::filter(get_mb21_poly(), SA4_NAME21 == "Brisbane - West"),
    pop = dplyr::filter(get_mb21_pop(), SA4_NAME21 == "Brisbane - West")
  )

  saveRDS(brisbane_west_mb, test_path("fixtures", "brisbane_west_mb.rds"))
}
