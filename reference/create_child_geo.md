# Create a child geography (polygon) which fits neatly into a parent geography

Create a child geography (polygon) which fits neatly into a parent
geography

## Usage

``` r
create_child_geo(
  child_geo,
  parent_geo,
  mb_geo = get_mb21_pop(),
  mb_poly = get_mb21_poly(),
  minimum_majority_portions = 0.95
)
```

## Arguments

- child_geo:

  Child geography (`sf` polygon or multipolygon) which is to be adjusted
  to fit within `parent_geo`.

- parent_geo:

  Parent geography (`sf` polygon or multipolygon) which the child
  geography is being adapted to fit within.

- mb_geo:

  Mesh blocks geography with `Person` column for population based
  mapping. Defaults to use 2021 edition and census data.

- mb_poly:

  Mesh blocks polygon for dissolving within subsets of polygons from
  `child_geo` that cross multiple polygons in `parent_geo`. Defaults to
  use 2021 edition.

- minimum_majority_portions:

  If the child geography has more than `minimum_majority_portions`
  proportion of their population within a single polygon within the
  `parent_geo`, it will not be split into multiple separate polygons.

## Value

An `sf` polygon or multipolygon.

## Examples

``` r
# \donttest{
sa3 <- get_polygon("sa32016")
lhns <- get_polygon("LHN")
#> The data for the Local Hospital Networks (LHN) are from here: <https://hub.arcgis.com/datasets/ACSQHC::local-hospital-networks/explore>
create_child_geo(sa3, lhns)
#> There are some polygons in the child_geo which are not contained within the parent_geo. Assigning these to the nearest polygon in the parent_geo
#> Simple feature collection with 396 features and 2 fields
#> Geometry type: GEOMETRY
#> Dimension:     XY
#> Bounding box:  xmin: 96.81695 ymin: -43.74048 xmax: 167.9969 ymax: -9.219923
#> Geodetic CRS:  GDA2020
#> First 10 features:
#>    sa3_code_2016            LHN_Name                       geometry
#> 1          10102        Southern NSW MULTIPOLYGON (((149.979 -35...
#> 2          10103        Southern NSW MULTIPOLYGON (((148.8041 -3...
#> 3          10104        Southern NSW MULTIPOLYGON (((150.3344 -3...
#> 4          10105        Southern NSW MULTIPOLYGON (((149.0114 -3...
#> 5        10106-A        Murrumbidgee MULTIPOLYGON (((148.6496 -3...
#> 6        10106-B        Southern NSW POLYGON ((148.6936 -35.1997...
#> 7          10201 Central Coast (NSW) MULTIPOLYGON (((151.315 -33...
#> 8          10202 Central Coast (NSW) MULTIPOLYGON (((151.485 -33...
#> 9          10301         Western NSW MULTIPOLYGON (((149.323 -33...
#> 10       10302-A        Murrumbidgee POLYGON ((147.4176 -34.2052...
# }
```
