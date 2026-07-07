# Re-throw an `osrm::osrmTable()` error, adding a hint for the known Windows curl/SSL backend issue

Re-throw an
[`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html)
error, adding a hint for the known Windows curl/SSL backend issue

## Usage

``` r
.osrm_table_error(e)
```

## Arguments

- e:

  The condition raised by
  [`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html).

## Value

Never returns; always raises an error.
