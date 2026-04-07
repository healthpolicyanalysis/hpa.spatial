# Modified Monash Model polygons (SA1, 2016 edition, polygons with MMM, 2019 edition column)

Modified Monash Model polygons (SA1, 2016 edition, polygons with MMM,
2019 edition column)

## Usage

``` r
get_mmm19_poly(export_dir = tempdir())
```

## Arguments

- export_dir:

  The directory to store the downloaded data.

## Value

An `sf` object.

## Examples

``` r
get_mmm19_poly()
#> Simple feature collection with 57490 features and 18 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 96.81695 ymin: -43.74048 xmax: 167.9969 ymax: -9.219937
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>     SA1_MAIN16 sa1_7dig_2016 sa2_code_2016 sa2_5dig_2016 sa2_name_2016
#> 1  10102100701       1100701     101021007         11007     Braidwood
#> 2  10102100702       1100702     101021007         11007     Braidwood
#> 3  10102100703       1100703     101021007         11007     Braidwood
#> 4  10102100704       1100704     101021007         11007     Braidwood
#> 5  10102100705       1100705     101021007         11007     Braidwood
#> 6  10102100706       1100706     101021007         11007     Braidwood
#> 7  10102100707       1100707     101021007         11007     Braidwood
#> 8  10102100708       1100708     101021007         11007     Braidwood
#> 9  10102100709       1100709     101021007         11007     Braidwood
#> 10 10102100710       1100710     101021007         11007     Braidwood
#>    sa3_code_2016 sa3_name_2016 sa4_code_2016  sa4_name_2016 gcc_code_2016
#> 1          10102    Queanbeyan           101 Capital Region         1RNSW
#> 2          10102    Queanbeyan           101 Capital Region         1RNSW
#> 3          10102    Queanbeyan           101 Capital Region         1RNSW
#> 4          10102    Queanbeyan           101 Capital Region         1RNSW
#> 5          10102    Queanbeyan           101 Capital Region         1RNSW
#> 6          10102    Queanbeyan           101 Capital Region         1RNSW
#> 7          10102    Queanbeyan           101 Capital Region         1RNSW
#> 8          10102    Queanbeyan           101 Capital Region         1RNSW
#> 9          10102    Queanbeyan           101 Capital Region         1RNSW
#> 10         10102    Queanbeyan           101 Capital Region         1RNSW
#>    gcc_name_2016 state_code_2016 state_name_2016 areasqkm_2016 cent_long
#> 1    Rest of NSW               1 New South Wales      362.8727  149.8577
#> 2    Rest of NSW               1 New South Wales      229.7459  149.8030
#> 3    Rest of NSW               1 New South Wales        2.3910  149.7896
#> 4    Rest of NSW               1 New South Wales        1.2816  149.8023
#> 5    Rest of NSW               1 New South Wales        1.1978  149.7968
#> 6    Rest of NSW               1 New South Wales       63.3894  149.7359
#> 7    Rest of NSW               1 New South Wales      442.7713  149.8338
#> 8    Rest of NSW               1 New South Wales     1137.7239  149.6201
#> 9    Rest of NSW               1 New South Wales      350.9881  149.7355
#> 10   Rest of NSW               1 New South Wales      825.9908  150.0091
#>     cent_lat MMM2019     MMM2019_label                       geometry
#> 1  -35.14608       5 Small rural towns MULTIPOLYGON (((149.7606 -3...
#> 2  -35.43467       5 Small rural towns MULTIPOLYGON (((149.8176 -3...
#> 3  -35.43858       5 Small rural towns MULTIPOLYGON (((149.7988 -3...
#> 4  -35.43902       5 Small rural towns MULTIPOLYGON (((149.7988 -3...
#> 5  -35.44991       5 Small rural towns MULTIPOLYGON (((149.7965 -3...
#> 6  -35.58121       5 Small rural towns MULTIPOLYGON (((149.8062 -3...
#> 7  -35.61750       5 Small rural towns MULTIPOLYGON (((149.9774 -3...
#> 8  -35.68669       5 Small rural towns MULTIPOLYGON (((149.5157 -3...
#> 9  -35.27190       5 Small rural towns MULTIPOLYGON (((149.6655 -3...
#> 10 -35.25637       5 Small rural towns MULTIPOLYGON (((149.9774 -3...
```
