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
