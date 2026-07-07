# Extract lon/lat coordinates (and row ids) from an sf/sfc POINT input

Extract lon/lat coordinates (and row ids) from an sf/sfc POINT input

## Usage

``` r
.osrm_pair_coords(x, arg_name)
```

## Arguments

- x:

  An sf or sfc object of type POINT.

- arg_name:

  The name of the argument being checked, used in error messages.

## Value

A `tibble` with `id`, `lon` and `lat` columns.
