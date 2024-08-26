load_wb_sa3_and_hhs_mapping_shapes <- function() {
  wb_mb21_pop <- readRDS(test_path("fixtures/brisbane_west_mb.rds"))$pop

  wb_sa32016 <- suppressMessages(get_polygon(name = "sa32016", crs = 7844)) |>
    dplyr::filter(sa4_name_2016 == "Brisbane - West")

  qld_lhn <- suppressMessages(get_polygon(name = "LHN")) |>
    dplyr::filter(state == "QLD")

  list(
    wb_mb21_pop = wb_mb21_pop,
    wb_sa32016 = wb_sa32016,
    qld_lhn = qld_lhn
  )
}
