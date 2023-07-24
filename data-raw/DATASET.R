## code to prepare `DATASET` dataset goes here

# usethis::use_data(DATASET, overwrite = TRUE)


library(strayr)
library(dplyr)

# ASGS table for 2011 edition
asgs_2011 <- as.data.frame(read_absmap("sa12011")) |>
  select(
    -all_of(c("geometry", "cent_long", "cent_lat", "areasqkm_2011")),
    -starts_with("state")
  )

# usethis::use_data(asgs_2011, overwrite = TRUE)

# ASGS table for 2016 edition
asgs_2016 <- as.data.frame(read_absmap("sa12016")) |>
  select(
    -all_of(c("geometry", "cent_long", "cent_lat", "areasqkm_2016")),
    -starts_with("state")
  )

# usethis::use_data(asgs_2016, overwrite = TRUE)

# ASGS table for 2016 edition
asgs_2021 <- as.data.frame(read_absmap("sa12021")) |>
  select(
    -all_of(c("geometry", "cent_long", "cent_lat", "areasqkm_2021")),
    -starts_with("state")
  )

# usethis::use_data(asgs_2021, overwrite = TRUE)

save(
  list = c("asgs_2011", "asgs_2016", "asgs_2021"),
  file = "R/sysdata.rda",
  compress = "xz"
)


# download and save make SA-PHN correspondence tables
get_sa_phn_correspondence <- function(url) {
  # download file
  tfile <- tempfile()
  download.file(url = url, destfile = tfile)

  # read data and check n_rows that are not trash at the end of the sheet
  df_check <- readxl::read_xlsx(tfile, sheet = "Table 3", skip = 4)
  n_max <- which(is.na(df_check[[1]]))[2]

  df <- readxl::read_xlsx(tfile, sheet = "Table 3", skip = 4, n_max = n_max)


  df |>
    dplyr::filter(!is.na(!!rlang::sym(names(df)[1]))) |>  # remove any empty rows between header and data
    dplyr::rename("ratio" = "RATIO")
}


sa_phn_correspondence_tables <- c(
  "sa1" = "https://www.health.gov.au/sites/default/files/documents/2021/06/primary-health-networks-phn-concordance-files-australian-statistical-geography-standards-statistical-area-level-1-2017-primary-health-networks-phn-concordance-files-australian-statistical-geography-standards-statistical-a.xlsx",
  "sa2" = "https://www.health.gov.au/sites/default/files/documents/2021/06/primary-health-networks-phn-concordance-files-australian-statistical-geography-standards-statistical-area-level-2-2017-primary-health-networks-phn-concordance-files-australian-statistical-geography-standards-statistical-a.xlsx",
  "sa3" = "https://www.health.gov.au/sites/default/files/documents/2021/06/primary-health-networks-phn-concordance-files-australian-statistical-geography-standards-statistical-area-level-3-2017-primary-health-networks-phn-concordance-files-australian-statistical-geography-standards-statistical-a.xlsx"
) |>
  lapply(get_sa_phn_correspondence)

usethis::use_data(sa_phn_correspondence_tables)


qld_hhs <- sf::read_sf("data-raw/QSC_Extracted_Data_20230724_114923035000-49708/Hospital_and_Health_Service_boundaries.shp")

usethis::use_data(qld_hhs)




# library(strayr)
# library(tidyverse)
# library(sf)
#
#
# # download mesh blocks for 2021 population data
# if(!"mb_2021.rds" %in% list.files(file.path(here::here(), "data-raw"))) {
#   utils::download.file(
#     url = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/MB_2021_AUST_SHP_GDA2020.zip",
#     destfile = file.path(here::here(), "data-raw", "MB_2021_AUST_SHP_GDA2020.zip")
#   )
#   unzip(
#     zipfile = file.path(here::here(), "data-raw", "MB_2021_AUST_SHP_GDA2020.zip"),
#     exdir = file.path(here::here(), "data-raw", "MB_2021_AUST_SHP_GDA2020")
#   )
#
#   mb_2021 <- sf::read_sf("data-raw/MB_2021_AUST_SHP_GDA2020/MB_2021_AUST_GDA2020.shp")
#
#
#   tempf <- tempfile(fileext = ".xlsx")
#   utils::download.file(
#     url = "https://www.abs.gov.au/census/guide-census-data/mesh-block-counts/2021/Mesh%20Block%20Counts%2C%202021.xlsx",
#     destfile = tempf
#   )
#
#   mb_data_all <- lapply(
#     2:12,
#     \(sheet){
#       xl_sheet <- readxl::read_xlsx(tempf, sheet=sheet, skip = 6)
#
#       # find the first row with an NA code and read up to (but excluding) that one
#       end_row <- which(is.na(xl_sheet$MB_CODE_2021))[1] - 1
#       readxl::read_xlsx(tempf, sheet=sheet, skip = 6, n_max = end_row)
#     }
#   ) |>
#     (\(x) do.call("rbind", x))()
#
#   # join population data to sf object
#   mb_2021 <- left_join(mb_2021, mb_data_all, by = c("MB_CODE21" = "MB_CODE_2021"))
#
#   saveRDS(
#     mb_2021,
#     file.path(here::here(), "data-raw", "mb_2021.rds")
#   )
# } else {
#   mb_2021 <- readRDS(file.path(here::here(), "data-raw", "mb_2021.rds"))
# }
#
#
# # save mb_2021 by state to reduce memory demands
# for(ste_code in unique(mb_2021$STE_CODE21)) {
#   mb_2021_filtered <- filter(mb_2021, STE_CODE21 == ste_code)
#   saveRDS(
#     mb_2021_filtered,
#     file.path(here::here(), "data-raw", paste0("mb_2021_ste", ste_code, ".rds"))
#   )
# }
# rm(list = ls())
#
# sa2_2016 <- read_absmap("sa22016")
# sa2_2021 <- read_absmap("sa22021")
# pcode_2016 <- read_absmap("postcode2016")
#
# pcode_2016 |>
#   filter(postcode_num_2016==6166)
#
# test_codes <- hpa.ASGS::pcode_sa2 |> filter(pcode==6166) |> pull(sa2)
#
# ggplot() +
#   geom_sf(data=sa2_2016 |> filter(sa2_code_2016 %in% test_codes), aes(fill = sa2_code_2016), alpha=0.3) +
#   geom_sf(data=pcode_2016 |> filter(postcode_num_2016==6166), aes(fill = "6166"), alpha=0.3)
#
#
# # prop in hpa.ASGS::pcode_sa2 currently represents the proportion of the SA2 within the pcode.
# hpa.ASGS::pcode_sa2 |> filter(pcode==6166)
# ggplot() +
#   geom_sf(data=sa2_2016 |> filter(sa2_code_2016 ==507011152 ), aes(fill = sa2_code_2016), alpha=0.3)+
#   geom_sf(data=pcode_2016 |> filter(postcode_num_2016==6166), aes(fill = "6166"), alpha=0.3)
#
#
#
# update_crs_to_GDA2020 <- function(geom) {
#   if(st_crs(geom)$input != "GDA2020"){
#     geom <- st_transform(geom, 7844)
#   }
#   geom
# }
#
# calculate_prop_overlaps <- function(geometry_numer, geometry_denom, geometry_sa2 = sa2_2021) {
#   # TODO:
#   #   - calculate proportion of geometry_numer in geometry_denom in terms of:
#   #     - area
#   #     - population using mesh block population data
#
#   # calculates the proportion as that of the numerator within the denominator. If the numerator polygon is completely contained within the denominator, the prop will be 1.
#   get_mb_data(geometry_numer, geometry_denom)
#
#   geometry_numer <- update_crs_to_GDA2020(geometry_numer)
#   geometry_denom <- update_crs_to_GDA2020(geometry_denom)
#   geometry_sa2 <- update_crs_to_GDA2020(geometry_sa2)
#
#   intersect_polygon <- st_intersection(geometry_numer, geometry_denom)
#   area_intersect <- st_area(intersect_polygon)
#   area_numer <- st_area(geometry_numer)
#   area_prop <- as.numeric(area_intersect/area_numer)
#
#
#   sa2_intersect <- st_intersection(intersect_polygon, geometry_sa2)
#   mb_intersect <- st_intersection(intersect_polygon, mb_data_use[mb_data_use$SA2_CODE21 %in% unique(sa2_intersect$sa2_code_2021),])
#   intersect_pop <- sum(mb_intersect$Person)
#
#   sa2_intersect <- st_intersection(geometry_numer, geometry_sa2)
#   mb_intersect <- st_intersection(geometry_numer, mb_data_use[mb_data_use$SA2_CODE21 %in% unique(sa2_intersect$sa2_code_2021),])
#   numer_pop <- sum(mb_intersect$Person)
#
#   pop_prop <- intersect_pop/numer_pop
#
#   res_df <- data.frame(
#     as.data.frame(geometry_numer)[1,1],
#     as.data.frame(geometry_denom)[1,1],
#     area_prop,
#     pop_prop
#   )
#
#   names(res_df)[1:2] <- c(
#     names(geometry_numer)[1],
#     names(geometry_denom)[1]
#   )
#
#   res_df
# }
#
# get_mb_data <- function(geometry_numer, geometry_denom) {
#   if(!"mb_data_use" %in% ls(globalenv())){
#     state_avail <- c()
#   } else {
#     state_avail <- unique(mb_data_use$STE_CODE21)
#   }
#
#   state_req <- c()
#
#   if(any(str_detect(names(geometry_numer), "state_code"))) {
#     state_req <- geometry_numer |>
#       as.data.frame() |>
#       pull(starts_with("state_code")) |>
#       unique() |>
#       append(state_req)
#   }
#
#   if(any(str_detect(names(geometry_denom), "state_code"))) {
#     state_req <-
#       geometry_denom |>
#       as.data.frame() |>
#       pull(starts_with("state_code")) |>
#       unqiue() |>
#       append(state_req)
#   }
#
#   stopifnot(length(state_req) == 1)
#
#   if(!all(state_req %in% state_avail)) {
#     mb_data_use <<- readRDS(
#       file.path(
#         here::here(),
#         "data-raw",
#         paste0("mb_2021_ste", state_req, ".rds"))
#     )
#   }
# }
#
# # mb_2021 <- mb_2021 |> filter(STE_NAME21=="Western Australia") # make the mb_data smaller for faster testing
# calculate_prop_overlaps(
#   # test to replicate hpa.ASGS::pcode_sa2
#   geometry_numer = filter(sa2_2016, sa2_code_2016 == 507011152),
#
#   geometry_denom = filter(pcode_2016, postcode_num_2016 == 6166)
#   # mb_data = mb_2021
#   # numerator = SA2
#   # denominator = pcode
# )
#
# test_intersect <- st_intersection(
#   filter(sa2_2016, state_code_2016 == "5"),
#   filter(pcode_2016, str_detect(postcode_2016, "^6"))
# )


# SA1s within pcodes to make filtering of mesh blocks faster
