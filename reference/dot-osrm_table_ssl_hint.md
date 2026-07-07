# Build a hint for the known Windows curl/SSL backend issue, if relevant

Build a hint for the known Windows curl/SSL backend issue, if relevant

## Usage

``` r
.osrm_table_ssl_hint(msg)
```

## Arguments

- msg:

  The error message from a failed
  [`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html)
  call.

## Value

A character string (possibly empty) to append to a warning message.
