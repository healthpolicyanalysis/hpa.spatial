# Get a correspondence table, either via `strayr::read_correspondence_tbl` or by creating one with `make_correspondence_tbl`

Get a correspondence table, either via
[`strayr::read_correspondence_tbl`](https://runapp-aus.github.io/strayr/reference/read_correspondence_tbl.html)
or by creating one with `make_correspondence_tbl`

## Usage

``` r
get_correspondence_tbl(
  from_area = NULL,
  from_year = NULL,
  from_geo = NULL,
  to_area = NULL,
  to_year = NULL,
  to_geo = NULL,
  export_dir = tempdir(),
  export_fname = NULL,
  mb_geo = get_mb21_pop()
)
```

## Arguments

- from_area:

  The area you want to correspond FROM (i.e. the areas your data are
  currently in). For example: 'sa1', 'sa2', 'sa3', 'sa4'.

- from_year:

  The year you want to correspond FROM. For example: 2011, 2016.

- from_geo:

  The FROM polygon geography. Helpful if it is not available using
  `from_year` and `from_area` in `get_polygon`.

- to_area:

  The area you want to correspond TO (i.e. the areas you want your data
  to be in).

- to_year:

  The year you want to correspond TO.

- to_geo:

  The TO polygon geography. Helpful if it is not available using
  `to_year` and `to_area` in `get_polygon`.

- export_dir:

  The directory to store the downloaded data.

- export_fname:

  The file name for the saved file (applicable if `from_geo`) and
  `to_geo` are used instead of areas and years).

- mb_geo:

  mesh blocks data with census population. Defaults to using the 2021
  edition mesh blocks and 2021 census data (see
  [`get_mb21_pop()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_mb21_pop.md)).

## Value

A `tibble`.

## Examples

``` r
get_correspondence_tbl(from_area = "sa2", from_year = 2021, to_area = "LHN")
#> Error in get(filename) : object 'CG_SA2_2021_LHN_' not found
#> Last resort: making correspondence table using shapes and population at mesh block level
#> The data for the Local Hospital Networks (LHN) are from here: <https://hub.arcgis.com/datasets/ACSQHC::local-hospital-networks/explore>
#> # A tibble: 2,526 × 3
#>    sa2_code_2021 LHN_Name     ratio
#>    <chr>         <chr>        <dbl>
#>  1 101021007     Southern NSW     1
#>  2 101021008     Southern NSW     1
#>  3 101021009     Southern NSW     1
#>  4 101021010     Southern NSW     1
#>  5 101021012     Southern NSW     1
#>  6 101021610     Southern NSW     1
#>  7 101021611     Southern NSW     1
#>  8 101031013     Southern NSW     1
#>  9 101031014     Southern NSW     1
#> 10 101031015     Southern NSW     1
#> # ℹ 2,516 more rows
```
