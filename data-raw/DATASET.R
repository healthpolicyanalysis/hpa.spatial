## code to prepare `DATASET` dataset goes here

usethis::use_data(DATASET, overwrite = TRUE)

library(strayr)
library(tidyverse)
library(sf)


# download mesh blocks for 2021 population data
if(!"mb_2021.rds" %in% list.files(file.path(here::here(), "data-raw"))) {
  utils::download.file(
    url = "https://www.abs.gov.au/statistics/standards/australian-statistical-geography-standard-asgs-edition-3/jul2021-jun2026/access-and-downloads/digital-boundary-files/MB_2021_AUST_SHP_GDA2020.zip",
    destfile = file.path(here::here(), "data-raw", "MB_2021_AUST_SHP_GDA2020.zip")
  )
  unzip(
    zipfile = file.path(here::here(), "data-raw", "MB_2021_AUST_SHP_GDA2020.zip"),
    exdir = file.path(here::here(), "data-raw", "MB_2021_AUST_SHP_GDA2020")
  )

  mb_2021 <- sf::read_sf("data-raw/MB_2021_AUST_SHP_GDA2020/MB_2021_AUST_GDA2020.shp")


  tempf <- tempfile(fileext = ".xlsx")
  utils::download.file(
    url = "https://www.abs.gov.au/census/guide-census-data/mesh-block-counts/2021/Mesh%20Block%20Counts%2C%202021.xlsx",
    destfile = tempf
  )

  mb_data_all <- lapply(
    2:12,
    \(sheet){
      xl_sheet <- readxl::read_xlsx(tempf, sheet=sheet, skip = 6)

      # find the first row with an NA code and read up to (but excluding) that one
      end_row <- which(is.na(xl_sheet$MB_CODE_2021))[1] - 1
      readxl::read_xlsx(tempf, sheet=sheet, skip = 6, n_max = end_row)
    }
  ) |>
    (\(x) do.call("rbind", x))()

  # join population data to sf object
  mb_2021 <- left_join(mb_2021, mb_data_all, by = c("MB_CODE21" = "MB_CODE_2021"))

  saveRDS(
    mb_2021,
    file.path(here::here(), "data-raw", "mb_2021.rds")
  )
} else {
  mb_2021 <- readRDS(file.path(here::here(), "data-raw", "mb_2021.rds"))
}



sa2_2016 <- read_absmap("sa22016")
sa2_2021 <- read_absmap("sa22021")
pcode_2016 <- read_absmap("postcode2016")

pcode_2016 |>
  filter(postcode_num_2016==6166)

test_codes <- hpa.ASGS::pcode_sa2 |> filter(pcode==6166) |> pull(sa2)

ggplot() +
  geom_sf(data=sa2_2016 |>filter(sa2_code_2016 %in% test_codes), aes(fill = sa2_code_2016), alpha=0.3) +
  geom_sf(data=pcode_2016 |>filter(postcode_num_2016==6166), aes(fill = "6166"), alpha=0.3)


# prop in hpa.ASGS::pcode_sa2 currently represents the proportion of the SA2 within the pcode.
hpa.ASGS::pcode_sa2 |> filter(pcode==6166)
ggplot() +
  geom_sf(data=sa2_2016 |> filter(sa2_code_2016 ==507011152 ), aes(fill = sa2_code_2016), alpha=0.3)+
  geom_sf(data=pcode_2016 |> filter(postcode_num_2016==6166), aes(fill = "6166"), alpha=0.3)



calculate_prop_overlaps <- function(geometry_numer, geometry_denom, mb_data = mb_2021, geometry_sa2 = sa2_2021) {
  # TODO:
  #   - calculate proportion of geometry_numer in geometry_denom in terms of:
  #     - area
  #     - population using mesh block population data

  # calculates the proportion as that of the numerator within the denominator. If the numerator polygon is completely contained within the denominator, the prop will be 1.

  update_crs_to_GDA2020 <- function(geom) {
    if(st_crs(geom)$input != "GDA2020"){
      geom <- st_transform(geom, 7844)
    }
    geom
  }

  geometry_numer <- update_crs_to_GDA2020(geometry_numer)
  geometry_denom <- update_crs_to_GDA2020(geometry_denom)
  geometry_sa2 <- update_crs_to_GDA2020(geometry_sa2)

  intersect_polygon <- st_intersection(geometry_numer, geometry_denom)
  area_intersect <- st_area(intersect_polygon)
  area_numer <- st_area(geometry_numer)
  area_prop <- as.numeric(area_intersect/area_numer)


  sa2_intersect <- st_intersection(intersect_polygon, geometry_sa2)
  mb_intersect <- st_intersection(intersect_polygon, mb_data[mb_data$SA2_CODE21 %in% unique(sa2_intersect$sa2_code_2021),])
  intersect_pop <- sum(mb_intersect$Person)

  sa2_intersect <- st_intersection(geometry_numer, geometry_sa2)
  mb_intersect <- st_intersection(geometry_numer, mb_data[mb_data$SA2_CODE21 %in% unique(sa2_intersect$sa2_code_2021),])
  numer_pop <- sum(mb_intersect$Person)

  pop_prop <- intersect_pop/numer_pop

  res_df <- data.frame(
    as.data.frame(geometry_numer)[1,1],
    as.data.frame(geometry_denom)[1,1],
    area_prop,
    pop_prop
  )

  names(res_df)[1:2] <- c(
    names(geometry_numer)[1],
    names(geometry_denom)[1]
  )

  res_df
}

# mb_2021 <- mb_2021 |> filter(STE_NAME21=="Western Australia") # make the mb_data smaller for faster testing
calculate_prop_overlaps(
  # test to replicate hpa.ASGS::pcode_sa2
  geometry_numer = filter(sa2_2016, sa2_code_2016==507011152),

  geometry_denom = filter(pcode_2016, postcode_num_2016 == 6166),
  mb_data = mb_2021
  # numerator = SA2
  # denominator = pcode
)


