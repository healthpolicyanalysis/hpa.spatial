# Get shapefiles from ABS (via `strayr` and `absmapsdata` or via `hpa.spatial` and `hpa.spatial.data`)

Get shapefiles from ABS (via `strayr` and `absmapsdata` or via
`hpa.spatial` and `hpa.spatial.data`)

## Usage

``` r
get_polygon(
  name = NULL,
  area = NULL,
  year = NULL,
  export_dir = tempdir(),
  simplify_keep = 1,
  crs = NULL,
  quiet = getOption("hpa.spatial.quiet", FALSE),
  ...
)
```

## Arguments

- name:

  A character string containing `absmapsdata` file names in
  `[area][year]` format, eg "sa42016"; "gcc2021". See full list at
  \<https://github.com/wfmackey/absmapsdata\>. Note: if name is entered,
  then area and year values will be ignored.

- area:

  A character string containing the concise absmapsdata area names, eg
  "sa4"; "gcc". See full list at
  \<https://github.com/wfmackey/absmapsdata\>.

- year:

  A character string or numeric of the full source year of `absmapsdata`
  object, eg "2016"; 2021. See full list at
  \<https://github.com/wfmackey/absmapsdata\>.

- export_dir:

  Path to a directory to store the desired sf object.
  [`tempdir()`](https://rdrr.io/r/base/tempfile.html) by default.

- simplify_keep:

  The proportion of points to retain (0-1; default 1 - no
  simplification).

- crs:

  Whether to update the crs (if necessary) of the returned polygon.

- quiet:

  whether to be quiet about warnings and messages. Set package level
  quiet-ness with `options(hpa.spatial.quiet = TRUE)`.

- ...:

  Arguments passed to
  [`rmapshaper::ms_simplify()`](http://andyteucher.ca/rmapshaper/reference/ms_simplify.md)
  (other than `keep`).

## Value

A polygon of class `sf`.

## Examples

``` r
get_polygon(area = "sa2", year = 2016)
#> Simple feature collection with 2310 features and 14 fields (with 18 geometries empty)
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 96.81695 ymin: -43.74048 xmax: 167.9969 ymax: -9.219937
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>    sa2_code_2016 sa2_5dig_2016                   sa2_name_2016 sa3_code_2016
#> 1      101021007         11007                       Braidwood         10102
#> 2      101021008         11008                         Karabar         10102
#> 3      101021009         11009                      Queanbeyan         10102
#> 4      101021010         11010               Queanbeyan - East         10102
#> 5      101021011         11011               Queanbeyan Region         10102
#> 6      101021012         11012 Queanbeyan West - Jerrabomberra         10102
#> 7      101031013         11013                         Bombala         10103
#> 8      101031014         11014                           Cooma         10103
#> 9      101031015         11015                    Cooma Region         10103
#> 10     101031016         11016           Jindabyne - Berridale         10103
#>      sa3_name_2016 sa4_code_2016  sa4_name_2016 gcc_code_2016 gcc_name_2016
#> 1       Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 2       Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 3       Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 4       Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 5       Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 6       Queanbeyan           101 Capital Region         1RNSW   Rest of NSW
#> 7  Snowy Mountains           101 Capital Region         1RNSW   Rest of NSW
#> 8  Snowy Mountains           101 Capital Region         1RNSW   Rest of NSW
#> 9  Snowy Mountains           101 Capital Region         1RNSW   Rest of NSW
#> 10 Snowy Mountains           101 Capital Region         1RNSW   Rest of NSW
#>    state_code_2016 state_name_2016 areasqkm_2016 cent_long  cent_lat
#> 1                1 New South Wales     3418.3525  149.7932 -35.45508
#> 2                1 New South Wales        6.9825  149.2328 -35.37590
#> 3                1 New South Wales        4.7634  149.2255 -35.35103
#> 4                1 New South Wales       13.0034  149.2524 -35.35520
#> 5                1 New South Wales     3054.4099  149.3911 -35.44408
#> 6                1 New South Wales       13.6789  149.2028 -35.37760
#> 7                1 New South Wales     3989.3618  149.0455 -36.87794
#> 8                1 New South Wales      103.6371  149.1194 -36.25023
#> 9                1 New South Wales     6250.8748  149.0822 -36.12715
#> 10               1 New South Wales     3939.5484  148.6089 -36.49170
#>                          geometry
#> 1  MULTIPOLYGON (((149.7606 -3...
#> 2  MULTIPOLYGON (((149.2192 -3...
#> 3  MULTIPOLYGON (((149.2315 -3...
#> 4  MULTIPOLYGON (((149.2315 -3...
#> 5  MULTIPOLYGON (((149.2563 -3...
#> 6  MULTIPOLYGON (((149.2064 -3...
#> 7  MULTIPOLYGON (((148.4221 -3...
#> 8  MULTIPOLYGON (((149.0751 -3...
#> 9  MULTIPOLYGON (((148.5512 -3...
#> 10 MULTIPOLYGON (((148.5512 -3...
get_polygon(name = "sa22016", simplify_keep = 0.05)
#> Reading sa22016 file found in /tmp/RtmpOgDGRM
#> Simple feature collection with 2268 features and 14 fields
#> Geometry type: GEOMETRY
#> Dimension:     XY
#> Bounding box:  xmin: 105.5507 ymin: -43.63203 xmax: 167.9969 ymax: -9.229287
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>           cent_long state_name_2016 state_code_2016 areasqkm_2016 gcc_name_2016
#> 1  149.793228574996 New South Wales               1     3418.3525   Rest of NSW
#> 2  149.232768065173 New South Wales               1        6.9825   Rest of NSW
#> 3  149.225475854377 New South Wales               1        4.7634   Rest of NSW
#> 4  149.252420473627 New South Wales               1       13.0034   Rest of NSW
#> 5  149.391126769656 New South Wales               1     3054.4099   Rest of NSW
#> 6   149.20281371599 New South Wales               1       13.6789   Rest of NSW
#> 7  149.045459322979 New South Wales               1     3989.3618   Rest of NSW
#> 8   149.11940402934 New South Wales               1      103.6371   Rest of NSW
#> 9  149.082197509622 New South Wales               1     6250.8748   Rest of NSW
#> 10 148.608930238752 New South Wales               1     3939.5484   Rest of NSW
#>    sa3_code_2016 gcc_code_2016  sa4_name_2016   sa3_name_2016
#> 1          10102         1RNSW Capital Region      Queanbeyan
#> 2          10102         1RNSW Capital Region      Queanbeyan
#> 3          10102         1RNSW Capital Region      Queanbeyan
#> 4          10102         1RNSW Capital Region      Queanbeyan
#> 5          10102         1RNSW Capital Region      Queanbeyan
#> 6          10102         1RNSW Capital Region      Queanbeyan
#> 7          10103         1RNSW Capital Region Snowy Mountains
#> 8          10103         1RNSW Capital Region Snowy Mountains
#> 9          10103         1RNSW Capital Region Snowy Mountains
#> 10         10103         1RNSW Capital Region Snowy Mountains
#>                      sa2_name_2016 sa2_5dig_2016 sa4_code_2016 sa2_code_2016
#> 1                        Braidwood         11007           101     101021007
#> 2                          Karabar         11008           101     101021008
#> 3                       Queanbeyan         11009           101     101021009
#> 4                Queanbeyan - East         11010           101     101021010
#> 5                Queanbeyan Region         11011           101     101021011
#> 6  Queanbeyan West - Jerrabomberra         11012           101     101021012
#> 7                          Bombala         11013           101     101031013
#> 8                            Cooma         11014           101     101031014
#> 9                     Cooma Region         11015           101     101031015
#> 10           Jindabyne - Berridale         11016           101     101031016
#>     cent_lat                       geometry
#> 1  -35.45508 POLYGON ((149.7606 -35.0834...
#> 2  -35.37590 POLYGON ((149.2192 -35.3601...
#> 3  -35.35103 POLYGON ((149.2315 -35.3422...
#> 4  -35.35520 POLYGON ((149.2315 -35.3422...
#> 5  -35.44408 POLYGON ((149.2563 -35.3901...
#> 6  -35.37760 POLYGON ((149.2064 -35.3458...
#> 7  -36.87794 POLYGON ((148.4221 -36.8886...
#> 8  -36.25023 POLYGON ((149.0751 -36.2404...
#> 9  -36.12715 POLYGON ((148.5512 -36.1042...
#> 10 -36.49170 POLYGON ((148.5512 -36.1042...
```
