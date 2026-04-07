# Map data between editions using correspondence tables from the ABS.

Map data between editions using correspondence tables from the ABS.

## Usage

``` r
map_data_with_correspondence(
  .data = NULL,
  codes,
  values,
  groups = NULL,
  from_area = NULL,
  from_year = NULL,
  from_geo = NULL,
  to_area = NULL,
  to_year = NULL,
  to_geo = NULL,
  correspondence_tbl = NULL,
  mb_geo = get_mb21_pop(),
  value_type = c("units", "aggs"),
  export_fname = NULL,
  round_values = FALSE,
  seed = NULL,
  quiet = getOption("hpa.spatial.quiet", FALSE)
)
```

## Arguments

- .data:

  A `data.frame`(-like) object. Can be passed if codes, values or groups
  are passed by reference (like in
  [`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)).

- codes:

  Codes representing locations relevant to the `from_area`. SA1 or SA2,
  for example.

- values:

  Values associated with codes to be allocated to newly mapped codes.

- groups:

  Values associated with codes/values specifying a grouping structure.
  For example, if there are codes/values for several age groups, then
  groups will be the grouping variable for the age group associated with
  the code and value of the same position. Defaults to `NULL` (no
  grouping).

- from_area:

  The area you want to correspond FROM (ie the areas your data are
  currently in). For example: "sa1", "sa2, "sa3", "sa4".

- from_year:

  The year you want to correspond FROM. For example: 2011, 2016.

- from_geo:

  The FROM polygon geography. Helpful if it is not available using
  `from_year` and `from_area` in `get_polygon`.

- to_area:

  The area you want to correspond TO (ie the areas you want your data to
  be in).

- to_year:

  The year you want to correspond TO.

- to_geo:

  The TO polygon geography. Helpful if it is not available using
  `to_year` and `to_area` in `get_polygon`.

- correspondence_tbl:

  A correspondence table to be used to map values between code sets. It
  should contain 3 columns: (1) code set FROM which values are being
  mapped, (2) code set TO which values are being mapped, and (3) a
  column named "ratio" containing the proportion/probability of the
  value(s) being mapped between the from- and to- code pair (row).
  Defaults to `NULL`, in which case it will attempt to get the
  correspondence table from the ABS and, if not available, it will
  create a correspondence table based on the overlap of the shapes and
  the residential population in the intersection (uses `mb_geo`
  argument).

- mb_geo:

  An `{sf}` POINT object where the points are the centroids of a small
  area (intended to be mesh blocks but can be any other space that's
  small enough to be useful. Should also include a column, `Person`,
  with the population within that area. Defaults to use Mesh
  Blocks (2021) and with 2021 census data. See
  [`get_mb21_pop()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_mb21_pop.md).

- value_type:

  Whether the data are unit level or aggregate level data. Unit level
  data is randomly allocated to new locations based on proportions in
  the correspondence table, aggregate data is dispersed based on the
  proportion across the (potentially multiple) mapped codes.

- export_fname:

  The file name for the saved correspondence table file (applicable if
  `from_geo`) and `to_geo` are used instead of areas and years).

- round_values:

  Whether or not to round the resulting mapped values to be whole
  numbers (maybe be useful when mapping count, aggregate values which
  may otherwise return decimal values in the mapped areas).

- seed:

  A random seed (integer). May be useful for ensuring mappings of unit
  level data are reproducible (as these use the mapping probabilities
  for randomly allocating observations to the new geographies and may be
  different between runs with the same data/inputs).

- quiet:

  whether to be quiet about warnings. Set package level quiet-ness with
  `options(hpa.spatial.quiet = TRUE)`.

## Value

A `data.frame`.

## Examples

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
#>   sa2_maincode_2016 values
#>   <chr>              <dbl>
#> 1 107011545             10
#> 2 107041548             10
map_data_with_correspondence(
  codes = c(107011130, 107041149),
  values = c(10, 10),
  from_area = "sa2",
  from_year = 2011,
  to_area = "sa2",
  to_year = 2016,
  value_type = "aggs"
)
#> # A tibble: 5 × 2
#>   sa2_maincode_2016 values
#>   <chr>              <dbl>
#> 1 107011545           4.82
#> 2 107011546           3.62
#> 3 107011547           1.57
#> 4 107041548           4.49
#> 5 107041549           5.51
```
