# Check for (and return if so) the shape if it is "internal" (contained within `hpa.spatial`/`hpa.spatial.data`)

Check for (and return if so) the shape if it is "internal" (contained
within `hpa.spatial`/`hpa.spatial.data`)

## Usage

``` r
check_for_internal_polygon(
  name = NULL,
  area = NULL,
  year = NULL,
  export_dir = tempdir(),
  quiet = getOption("hpa.spatial.quiet", FALSE),
  ...
)
```

## Arguments

- name:

  A character string names to identify data not kept on `absmapsdata`.

- area:

  A character string names to identify data not kept on `absmapsdata`.

- year:

  A character string names to identify data not kept on `absmapsdata`.

- export_dir:

  The directory to store the downloaded data.

- quiet:

  whether to be quiet about warnings and messages. Set package level
  quiet-ness with `options(hpa.spatial.quiet = TRUE)`.

- ...:

  Additional, ignored arguments.

## Value

An `sf` object or, if no pkg data found, `NULL`.

## Examples

``` r
# Get the Local Hospital Network (LHN) shapes.
shp <- check_for_internal_polygon(name = "LHN")
#> The data for the Local Hospital Networks (LHN) are from here: <https://hub.arcgis.com/datasets/ACSQHC::local-hospital-networks/explore>
```
