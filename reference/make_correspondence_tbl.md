# Create a correspondence table between any two geographies

Create a correspondence table between any two geographies

## Usage

``` r
make_correspondence_tbl(from_geo, to_geo, mb_geo = get_mb21_pop(), ...)
```

## Arguments

- from_geo:

  An `{sf}` POLYGON object.

- to_geo:

  An `{sf}` POLYGON object.

- mb_geo:

  An `{sf}` POINT object where the points are the centroids of a small
  area (intended to be mesh blocks but can be any other space that's
  small enough to be useful. Should also include a column, `Person`,
  with the population within that area. Defaults to use Mesh
  Blocks (2021) and with 2021 census data. See
  [`get_mb21_pop()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_mb21_pop.md).

- ...:

  other, ignored arguments.

## Value

A `tibble`.

## Examples

``` r
make_correspondence_tbl(
  from_geo = get_polygon("sa22016", crs = 7844),
  to_geo = get_polygon("sa22021", crs = 7844),
  mb_geo = get_mb21_pop()
)
#> Reading sa22016 file found in /tmp/RtmpAWFgwO
#> Reading sa22021 file found in /tmp/RtmpAWFgwO
#> # A tibble: 2,491 × 3
#>    sa2_code_2016 sa2_code_2021 ratio
#>    <chr>         <chr>         <dbl>
#>  1 101021007     101021007     1    
#>  2 101021008     101021008     1    
#>  3 101021009     101021009     1    
#>  4 101021010     101021010     1    
#>  5 101021011     101021610     0.273
#>  6 101021011     101021611     0.727
#>  7 101021012     101021012     1    
#>  8 101031013     101031013     1    
#>  9 101031014     101031014     1    
#> 10 101031015     101031015     1    
#> # ℹ 2,481 more rows
```
