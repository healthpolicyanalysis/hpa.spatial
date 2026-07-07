# Estimate drive times/distances for specific origin-destination pairs

A wrapper around
[`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html) for
when only specific origin-destination pairs are needed, rather than the
full matrix of travel times/distances between every combination of
points. Rather than sending every unique origin and every unique
destination to a single
[`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html) call
(which would request the full cross-product between them), pairs are
grouped by whichever of `origins` or `destinations` has fewer unique
points, and one
[`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html) call
is made per group, scoped only to the counterpart points actually paired
with it. This keeps each request small and avoids hitting a server's
max-table-size limit when there are many distinct pairs, at the cost of
issuing more requests than a single full-matrix call.

## Usage

``` r
osrm_table_pairs(
  origins,
  destinations,
  exclude,
  measure = "duration",
  osrm.server = getOption("osrm.server"),
  osrm.profile = getOption("osrm.profile")
)
```

## Arguments

- origins:

  Origin points, one row per pair, as an sf or sfc object of type POINT.
  If relevant, row names are used as identifiers.

- destinations:

  Destination points, one row per pair, matching `origins` row for row,
  as an sf or sfc object of type POINT with the same CRS as `origins`.

- exclude:

  Passed to
  [`osrm::osrmTable()`](https://rdrr.io/pkg/osrm/man/osrmTable.html): an
  optional "exclude" request option for the OSRM API (not allowed with
  the OSRM demo server).

- measure:

  A character indicating what measures are calculated. It can be
  "duration" (in minutes), "distance" (in meters), or both
  `c("duration", "distance")`.

- osrm.server:

  The base URL of the routing server.

- osrm.profile:

  The routing profile to use, e.g. "car", "bike" or "foot".

## Value

A `tibble` with one row per origin-destination pair, including the
origin and destination coordinates and ids, and the requested `duration`
(in minutes) and/or `distance` (in meters) columns.

## Examples

``` r
if (FALSE) { # \dontrun{
origins <- sf::st_as_sf(
  data.frame(lon = c(13.38, 13.40), lat = c(52.52, 52.50)),
  coords = c("lon", "lat"), crs = 4326
)
destinations <- sf::st_as_sf(
  data.frame(lon = c(13.41, 13.39), lat = c(52.53, 52.51)),
  coords = c("lon", "lat"), crs = 4326
)
osrm_table_pairs(origins, destinations)
} # }
```
