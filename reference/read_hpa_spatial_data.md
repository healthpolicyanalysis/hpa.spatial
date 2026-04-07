# Read a dataset from \<github.com/healthpolicyanalysis/hpa.spatial.data/\>

Read a dataset from
\<github.com/healthpolicyanalysis/hpa.spatial.data/\>

## Usage

``` r
read_hpa_spatial_data(name, export_dir = tempdir())
```

## Arguments

- name:

  The name of dataset in `hpa.spatial.data` repo. Valid names are those
  within `get_data_file_list()`.

- export_dir:

  The directory to store the downloaded data.

## Value

An `sf` object.

## Examples

``` r
read_hpa_spatial_data("lhn")
#> Simple feature collection with 63 features and 3 fields
#> Geometry type: GEOMETRY
#> Dimension:     XY
#> Bounding box:  xmin: 112.9211 ymin: -43.74036 xmax: 159.1092 ymax: -9.142176
#> Geodetic CRS:  GDA2020
#> # A tibble: 63 × 4
#>    LHN_Name              state STATE_CODE                               geometry
#>    <chr>                 <fct> <chr>                          <MULTIPOLYGON [°]>
#>  1 Central Coast (NSW)   NSW   1          (((151.5725 -33.29127, 151.5723 -33.2…
#>  2 Far West NSW          NSW   1          (((145.1595 -32.74717, 145.1484 -32.8…
#>  3 Hunter New England    NSW   1          (((152.5489 -32.0719, 152.5488 -32.07…
#>  4 Illawarra Shoalhaven  NSW   1          (((151.0662 -34.17233, 151.066 -34.17…
#>  5 Mid North Coast (NSW) NSW   1          (((153.2615 -29.94011, 153.2613 -29.9…
#>  6 Murrumbidgee          NSW   1          (((145.3385 -32.72168, 145.3378 -32.7…
#>  7 Nepean Blue Mountains NSW   1          (((151.1358 -33.10996, 151.1357 -33.1…
#>  8 Northern NSW          NSW   1          (((153.2602 -29.97412, 153.2605 -29.9…
#>  9 Northern Sydney       NSW   1          (((151.343 -33.62451, 151.343 -33.624…
#> 10 South Eastern Sydney  NSW   1          (((151.2658 -33.92539, 151.2659 -33.9…
#> # ℹ 53 more rows
```
