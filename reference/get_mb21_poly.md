# Get Mesh Blocks (2021 edition) polygons

Get Mesh Blocks (2021 edition) polygons

## Usage

``` r
get_mb21_poly(export_dir = tempdir())
```

## Arguments

- export_dir:

  The directory to store the downloaded data.

## Value

A `sf` object.

## Examples

``` r
get_mb21_poly()
#> Simple feature collection with 368286 features and 19 fields (with 31 geometries empty)
#> Geometry type: POLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 96.81695 ymin: -43.7405 xmax: 167.998 ymax: -9.142163
#> Geodetic CRS:  GDA2020
#> # A tibble: 368,286 × 20
#>    MB_CODE21   MB_CAT21    CHG_FLAG21 CHG_LBL21 SA1_CODE21 SA2_CODE21 SA2_NAME21
#>  * <chr>       <chr>       <chr>      <chr>     <chr>      <chr>      <chr>     
#>  1 10000010000 Residential 0          No change 109011172… 109011172  Albury - …
#>  2 10000021000 Commercial  0          No change 109011176… 109011176  Lavington 
#>  3 10000022000 Commercial  0          No change 109011176… 109011176  Lavington 
#>  4 10000023000 Commercial  0          No change 109011176… 109011176  Lavington 
#>  5 10000024000 Residential 0          No change 109011176… 109011176  Lavington 
#>  6 10000040000 Residential 0          No change 109011176… 109011176  Lavington 
#>  7 10000050000 Residential 0          No change 109011176… 109011176  Lavington 
#>  8 10000061000 Residential 0          No change 109011172… 109011172  Albury - …
#>  9 10000062000 Residential 0          No change 109011172… 109011172  Albury - …
#> 10 10000063000 Residential 0          No change 109011172… 109011172  Albury - …
#> # ℹ 368,276 more rows
#> # ℹ 13 more variables: SA3_CODE21 <chr>, SA3_NAME21 <chr>, SA4_CODE21 <chr>,
#> #   SA4_NAME21 <chr>, GCC_CODE21 <chr>, GCC_NAME21 <chr>, STE_CODE21 <chr>,
#> #   STE_NAME21 <chr>, AUS_CODE21 <chr>, AUS_NAME21 <chr>, AREASQKM21 <dbl>,
#> #   LOCI_URI21 <chr>, geometry <POLYGON [°]>
```
