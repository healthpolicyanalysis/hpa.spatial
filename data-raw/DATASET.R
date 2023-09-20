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
    dplyr::filter(!is.na(!!rlang::sym(names(df)[1]))) |> # remove any empty rows between header and data
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

library(tidyverse)
library(leaflet)
library(sf)

###
# load NSW LHD data from https://www.google.com/maps/d/u/0/viewer?mid=1Dv1JRTGmzlm83tBv7tb8vQcOQXY
sa_lhn <- sf::read_sf("data-raw/lhn/LocalHealthNetworks_GDA2020.shp")
sa_lhn <- st_transform(sa_lhn, 7844)
usethis::use_data(sa_lhn, overwrite = TRUE, compress = "xz")
# sa_lhn |> ggplot() + geom_sf()

phn <- sf::read_sf("data-raw/phn.kml")
phn <- st_transform(phn, 7844)
phn <- phn[, colSums(is.na(phn)) < nrow(phn)]
# usethis::use_data(phn, overwrite = TRUE)
usethis::use_data(phn, overwrite = TRUE, compress = "xz")
# phn |> ggplot() + geom_sf()


### create a complete dataset for LHNs (exception: Vic for now)
vic_lhn <- sf::read_sf("data-raw/vic-lhn/DHHS_Service_Areas.shp") |>
  select(LHN_Name = ServiceAre) |>
  add_column(STATE_CODE = "2")



all_lhn <- sf::read_sf("data-raw/LHN/Local_Hospital_Networks.shp") |>
  select(LHN_Name, STATE_CODE) |>
  bind_rows(vic_lhn) |>
  mutate(
    state = toupper(strayr::clean_state(STATE_CODE)),
    state = factor(
      state,
      levels = data.frame(state = unique(state), STATE_CODE = unique(STATE_CODE)) |>
        arrange(STATE_CODE) |>
        pull(state)
    )
  ) |>
  select(LHN_Name, state, STATE_CODE)

lhn <- st_transform(all_lhn, 7844)
usethis::use_data(lhn, overwrite = TRUE, compress = "xz")



# create qld meshblocks dataset with column for population for testing make_correspondence_tbl()

aus_mb21 <- read_sf("data-raw/mb/MB_2021_AUST_GDA2020.shp")
aus_mb21_points <- st_point_on_surface (aus_mb21)

aus_mb21_pops <- lapply(2:13, \(x) {
  readxl::read_xlsx("data-raw/mb/Mesh Block Counts, 2021.xlsx", skip = 6, sheet = x)
}) |>
  (\(x) do.call("rbind", x))()


aus_mb21_points_test <- left_join(
  aus_mb21_points,
  aus_mb21_pops,
  by = c("MB_CODE21" = "MB_CODE_2021")
)

sum(is.na(aus_mb21_points_test$Dwelling))
aus_mb21_points_test |>
  filter(is.na(Dwelling))

aus_mb21_points_test |>
  saveRDS(file.path(here::here(), "tests", "testthat", "fixtures", "mb21.rds"))

####


sa_phn_correspondence_tables$sa2

sa2_2016 <- strayr::read_absmap("sa22016")

sa2_qld_codes <- sa2_2016 |>
  filter(state_name_2016 == "Queensland") |>
  pull(sa2_code_2016)


sa_phn_correspondence_tables$sa2 |>
  filter(SA2_MAINCODE_2016 %in% sa2_qld_codes)


qld_hhs |>
  ggplot() +
  geom_sf(aes(fill = HHS), linetype = "dashed", lwd = 0.5, col = "red") +
  geom_sf(data = filter(sa2_2016, state_name_2016 == "Queensland"), lwd = 0.5, fill = "transparent") +
  labs(caption = "red dashed boarders are boarders of HHS's that aren't overlapped by an SA1 baorder.")


qld_hhs$HHS <- as.factor(qld_hhs$HHS)

f <- function(x) viridis::turbo(length(unique(x)))[x]

# some SA1s are not contained within a single HHS.
leaflet() |>
  addPolygons(
    data = qld_hhs,
    fillColor = f(qld_hhs$HHS),
    color = "black",
    fillOpacity = 0.5,
    weight = 1
  ) |>
  addPolygons(
    data = filter(sa2_2016, state_name_2016 == "Queensland"),
    fillColor = "black",
    fillOpacity = 0.5,
    weight = 2
  )



sa1_2016 <- strayr::read_absmap("sa12016")

leaflet() |>
  addPolygons(
    data = filter(sa1_2016, state_name_2016 == "Queensland"),
    fillColor = "black",
    fillOpacity = 0.5,
    weight = 2 # ,
    # popup = filter(sa1_2016, state_name_2016 == "Queensland") |> pull(sa1_code_2016 )
  ) |>
  addPolygons(
    data = qld_hhs,
    fillColor = f(qld_hhs$HHS),
    color = "black",
    fillOpacity = 0.5,
    weight = 1,
    popup = qld_hhs$HHS
  )


leaflet() |>
  addPolygons(data = filter(sa1_2016, sa1_code_2016 == 31503141004), fillColor = "red") |>
  addPolygons(data = filter(qld_hhs, HHS %in% c("North West", "Central West")), fillColor = "blue")


# f_sa1s <- filter(sa1_2016, sa1_code_2016 == 31503141004)
f_sa1s <- filter(sa1_2016, state_name_2016 == "Queensland") |>
  st_transform(crs = 7844)
# f_hss <- filter(qld_hhs, HHS %in% c("North West", "Central West"))

# sa1_2016
# st_intersects(f_sa1s, f_hss)
#
# st_intersects(f_sa1s, qld_hhs) |>
#   map(length) |>
#   (\(x)do.call("rbind", x))()



sa1_hhs_ints <-
  st_intersects(f_sa1s, qld_hhs) |>
  map(length) |>
  (\(x)do.call("rbind", x))() |>
  (\(x) x[, 1])()

f_sa1s$n_intersects <- sa1_hhs_ints

# f_sa1s |> filter(n_intersects == 2) |>
#   head() |>
#   st_intersects(qld_hhs)

intersects_check <- which(f_sa1s$n_intersects > 1)

intersects_main_area_prop <-
  intersects_check |>
  map(\(x){
    st_intersection(f_sa1s[x, ], qld_hhs) |>
      st_area() |>
      (\(x) max(x) / sum(x))()
  }, .progress = list(
    type = "iterator",
    format = "Calculating {cli::pb_bar} {cli::pb_percent}",
    clear = TRUE
  )) |>
  unlist()


f_sa1s$intersect_main_prop <- 1
f_sa1s$intersect_main_prop[intersects_check] <- intersects_main_area_prop

# just assign to the largest intersection area

intersects_check_main_hhs <- intersects_check |>
  map(\(x){
    intersects <- st_intersection(f_sa1s[x, ], qld_hhs)
    areas <- st_area(intersects)
    intersects[which(areas == max(areas)), ][["HHS"]]
  }, .progress = list(
    type = "iterator",
    format = "Calculating {cli::pb_bar} {cli::pb_percent}",
    clear = TRUE
  )) |>
  unlist()


intersects_single <- which(f_sa1s$n_intersects == 1)
intersects_single_hhs <-
  intersects_single |>
  map(\(x){
    intersects <- st_intersection(f_sa1s[x, ], qld_hhs)
    intersects[["HHS"]]
  }, .progress = list(
    type = "iterator",
    format = "Calculating {cli::pb_bar} {cli::pb_percent}",
    clear = TRUE
  )) |>
  unlist()

f_sa1s$main_hhs <- NA_character_
f_sa1s$main_hhs[intersects_single] <- as.character(intersects_single_hhs)
f_sa1s$main_hhs[intersects_check] <- as.character(intersects_check_main_hhs)


qld_sa1_2016_to_hhs <- select(as.data.frame(f_sa1s), sa1_code_2016, main_hhs)

usethis::use_data(qld_sa1_2016_to_hhs, overwrite = TRUE)


###

## make pop-based correspondence table for ASGS (SA1-3) to HHS

library(tidyverse)
library(sf)
devtools::load_all()

# load SA1s and convert to GDA2020
sa1_2016 <- strayr::read_absmap("sa12016")
sa1_2016 <- st_transform(sa1_2016, crs = st_crs(qld_hhs))



make_asgs_hhs_correspondence_data <- function(hhs, asgs) {
  # step 1: find all SA1s which are solely contained within a HHS

  # problematic SA1: 31503141004
  # which is within: c("North West", "Central West")
}


make_asgs_hhs_correspondence_data(hhs = qld_hhs, asgs = sa1_2016)

sa1_hhs_intersections <- st_within((sa1_2016 |> filter(state_name_2016 == "Queensland")), qld_hhs)




pt <- sf::st_point(c(153.2300, -27.53668))

c(152.6741, -25.56848)

st_intersects(st_multipoint(rbind(c(152.6741, -25.56848), c(153.2300, -27.53668))), qld_hhs)

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
