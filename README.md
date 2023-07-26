
<!-- README.md is generated from README.Rmd. Please edit that file -->

# hpa.spatial

<!-- badges: start -->
<!-- badges: end -->

The goal of hpa.spatial is to make relevant shape files and data easily
available and include helpful functions for analysis of spatial data.

## Notes on other packages

Shape files are available within
[`{absmapsdata}`](https://github.com/wfmackey/absmapsdata) and these can
be (lazy) loaded using
[`{strayr}`](https://github.com/runapp-aus/strayr).

## Installation

You can install the development version of hpa.spatial from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("healthpolicyanalysis/hpa.spatial")
```

``` r
library(hpa.spatial)
library(sf)
library(dplyr)
library(ggplot2)
```

## Getting shapefiles

`get_polygon()` is used to get shape files from the abs.

``` r
sa2_2016 <- get_polygon(area = "sa2", year = 2016)
head(sa2_2016)
#> Simple feature collection with 6 features and 14 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 149.0781 ymin: -36.00922 xmax: 150.2157 ymax: -34.98032
#> Geodetic CRS:  WGS 84
#>   sa2_code_2016 sa2_5dig_2016                   sa2_name_2016 sa3_code_2016
#> 1     101021007         11007                       Braidwood         10102
#> 2     101021008         11008                         Karabar         10102
#> 3     101021009         11009                      Queanbeyan         10102
#> 4     101021010         11010               Queanbeyan - East         10102
#> 5     101021011         11011               Queanbeyan Region         10102
#> 6     101021012         11012 Queanbeyan West - Jerrabomberra         10102
#>   sa3_name_2016 sa4_code_2016  sa4_name_2016 gcc_code_2016 gcc_name_2016
#> 1    Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 2    Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 3    Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 4    Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 5    Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 6    Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#>   state_code_2016 state_name_2016 areasqkm_2016 cent_long  cent_lat
#> 1               1 New South Wales     3418.3525  149.7932 -35.45508
#> 2               1 New South Wales        6.9825  149.2328 -35.37590
#> 3               1 New South Wales        4.7634  149.2255 -35.35103
#> 4               1 New South Wales       13.0034  149.2524 -35.35520
#> 5               1 New South Wales     3054.4099  149.3911 -35.44408
#> 6               1 New South Wales       13.6789  149.2028 -35.37760
#>                         geometry
#> 1 MULTIPOLYGON (((149.7606 -3...
#> 2 MULTIPOLYGON (((149.2192 -3...
#> 3 MULTIPOLYGON (((149.2315 -3...
#> 4 MULTIPOLYGON (((149.2315 -3...
#> 5 MULTIPOLYGON (((149.2563 -3...
#> 6 MULTIPOLYGON (((149.2064 -3...

sa2_2016 |>
  ggplot() +
  geom_sf() +
  theme_bw()
```

<img src="man/figures/README-unnamed-chunk-3-1.png" width="100%" />

This is used in the same way as `strayr::read_absmap()` except it also
includes a `simplify_keep` argument for simplifying the polygon.

``` r
sa2_2016_simple <- get_polygon(area = "sa2", year = 2016, simplify_keep = 0.1)

sa2_2016 |>
  filter(gcc_name_2016 == "Greater Brisbane") |>
  ggplot() +
  geom_sf() +
  scale_x_continuous(limits = c(152.9, 153.1)) +
  scale_y_continuous(limits = c(-27.4, -27.6)) +
  theme_bw()

sa2_2016_simple |>
  filter(gcc_name_2016 == "Greater Brisbane") |>
  ggplot() +
  geom_sf() +
  scale_x_continuous(limits = c(152.9, 153.1)) +
  scale_y_continuous(limits = c(-27.4, -27.6)) +
  theme_bw()
```

<img src="man/figures/README-unnamed-chunk-5-1.png" width="100%" />

## Mapping data between ASGS editions

`map_data_with_correspondence()` is used to map data across ASGS
editions.

When used with unit level data, it will randomly allocate the value to
the code of the updated edition based on the population-weighted
proportions (as probabiilties) on the relevant correspondence table.

``` r
map_data_with_correspondence(
  codes = c(107011130, 107041149),
  values = c(10, 10),
  from_area = "sa2",
  from_year = 2011,
  to_area = "sa2",
  to_year = 2016,
  value_type = "units"
)
#> # A tibble: 2 × 2
#> # Rowwise: 
#>   SA2_MAINCODE_2016 values
#>   <chr>              <dbl>
#> 1 107011547             10
#> 2 107041548             10
```

When used with aggregate data, it will split the value amongst the codes
of the updated edition based on the population-weighted proportions on
the relevant correspondence table.

``` r
map_data_with_correspondence(
  codes = c(107011130, 107041149),
  values = c(10, 10),
  from_area = "sa2",
  from_year = 2011,
  to_area = "sa2",
  to_year = 2016,
  value_type = "aggs"
)
#> Reading file found in /tmp/Rtmp3Iv1ty
#> # A tibble: 5 × 2
#>   SA2_MAINCODE_2016 values
#>   <chr>              <dbl>
#> 1 107011545           4.82
#> 2 107011546           3.62
#> 3 107011547           1.57
#> 4 107041548           4.49
#> 5 107041549           5.51
```
