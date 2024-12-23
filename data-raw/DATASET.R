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



# make hpa.spatial logo
library(hpa.spatial)
library(sf)
library(cowplot)
library(magick)
library(tidyverse)
library(hexSticker)

poly <- get_polygon("LHN")
hex_grid <- st_make_grid(poly, cellsize = 1.5, square = FALSE)

centroids <- st_centroid(hex_grid)
centroids_sf <- st_sf(data.frame(
  idx = 1:length(centroids),
  geom = centroids
))

intersected_polys <- st_intersection(centroids_sf, poly)

aus_hex <- st_sf(data.frame(
  geom = hex_grid[intersected_polys]
))

aus_hex$x <- st_coordinates(st_centroid(aus_hex))[, 1]
aus_hex$y <- st_coordinates(st_centroid(aus_hex))[, 2]
bbox <- sf::st_bbox(aus_hex)

text_coord <- data.frame(
  x = sum(bbox["xmin"], bbox["xmax"]) / 2,
  y = sum(bbox["ymin"], bbox["ymax"]) / 2,
  label = "spatial"
)

img <- readPNG("data-raw/HPA.png")

aus_plot <- ggplot() +
  geom_sf(data = aus_hex, aes(fill = -x)) +
  scale_fill_viridis_c(option = "magma") +
  theme_void() +
  theme(legend.position = "none") +
  scale_y_continuous()

p <- ggdraw() +
  draw_plot(aus_plot) +
  draw_image("data-raw/HPA.png", scale = 0.4, vjust = -0.05, hjust = 0)


sticker(
  p,
  package = "hpa.spatial", p_size = 20,
  s_x = 1,
  s_y = 0.8,
  s_width = 1.4,
  s_height = 1,
  p_color = "#1D2455",
  h_fill = "#408BCA",
  h_color = "#1D2455",
  filename = "inst/figures/hex.png"
)



# get 2023 ERP data
erp23_file <- "data-raw/32180DS0001_2022-23.xlsx"

sheets <- readxl::excel_sheets(erp23_file) |>
  str_subset("^Table [0-9]$") # skip table 10 (states)

sa2_erp23 <- map(
  sheets,
  ~readxl::read_excel(path = erp23_file, sheet = .x, skip = 6) |>
    janitor::clean_names() |>
    select(sa2_code_2021 = sa2_code, erp = no_10) |>
    mutate(sa2_code_2021 = as.character(sa2_code_2021))
) |>
  bind_rows() |>
  mutate(erp = replace_na(erp, 0)) |>
  filter(!is.na(sa2_code_2021))

usethis::use_data(sa2_erp23, overwrite = TRUE)

