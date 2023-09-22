# hpa.spatial (development version)

# hpa.spatial 0.2.1

* add `get_correspondence_tbl()` which calls `strayr::read_correspondence_tbl()`
  and if it fails to find one, it uses `make_correspondence_tbl()` to create 
  one. Takes the same args as `strayr::read_correspondence_tbl()` but with the 
  option to use a different mesh blocks edition/population data for 
  `make_correspondence_tbl()`.

* add `make_correspondence_tbl()` to create a correspondence table between two
  given geographies and a `POINT` geometry (`sf`) with population counts 
  (`Person` as is standard in mesh blocks data).

* added a `.data` argument to `map_data_with_correspondence()` so that `codes`,
  `values` and `groups` can be passed by reference (like in `dplyr::mutate()`).
  
* always returna a tibble from `map_data_with_correspondence()` (just for 
  consistency).

* add tests for (#3) which is a non-issue.

# hpa.spatial 0.2.0

* create an `lhn` dataset to replace the independent state datasets (`qld_hhs`,
  `nsw_lhd`, `sa_lhn` etc...).

* bug fix (#2): use `withr::with_package()` and `withr::with_environment()` to 
  evaluate calls in `get_polygon()` with hpa.spatial namespace within copy of 
  parent environment.

# hpa.spatial 0.1.1

* initial release with two main functions:

  * `get_polygon()` accesses the polygons from `{absmapsdata}` via 
  `strayr::read_absmap()` as well as some other shape files internal to this pkg
  
  * `map_data_with_correspondence()` allows the user to map data (unit or 
  aggregate values) across between editions of the ASGS as well as up within
  nested levels (i.e. SA2 to SA3).
  
