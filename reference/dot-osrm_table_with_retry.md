# Call `osrm::osrmTable()`, retrying once on error

Call [`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html),
retrying once on error

## Usage

``` r
.osrm_table_with_retry(table_args)
```

## Arguments

- table_args:

  A list of arguments to pass to
  [`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html).

## Value

The result of
[`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html), or
the `error` condition raised if it fails on both the original attempt
and the retry.
