# Changelog

## hpa.spatial (development version)

- let claude do a review and clean up some redundant code and arguments.

- update hpa.spatial.data commit ref to access the MMM23 lookup to SA1
  2021.

- update hpa.spatial.data commit ref to access the updated ACPR data.

- update my email in DESCRIPTION file.

- fix problem caused by
  [`sf::st_crs()`](https://r-spatial.github.io/sf/reference/st_crs.html)
  within `update_crs()` by importing {sf}.

- create new vignette with example of more complex mapping of data using
  more up-to-date ERP dataset to adjust correspondence table creation.

- add dataset (`sa2_erp23`) with estimated residential population (2023)
  at SA2 level.

## hpa.spatial 0.2.13

- remove hideous meta-programming that was handling the recursive
  calling of
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  (now that it’s not used recursively).

- where possible to use a combination of ASGS correspondence tables
  (including combining multiple) use these for mapping data across
  editions/geographies.

- avoid recursive programming for
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  by using new function: `.map_data_with_ct()`

- update testing suite to be faster to run and more comprehensive.

## hpa.spatial 0.2.12

- data read from `{hpa.spatial.data}` is read from a specific commit to
  ensure (from now on) old versions of
  [hpa.spatial](https://healthpolicyanalysis.github.io/hpa.spatial/)
  will read the same data as they are expected to (did at the time of
  analyses).

- allow user to specify a custom correspondence table to
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md).

- add access to recently added Aged Care Planning Region shape files (on
  `{hpa.spatial.data}`).

- only do GHA for R CMD CHECK on Windows.

- update README.

- update vignettes.

## hpa.spatial 0.2.11

- Ensure that SA2s can completely map to LHNs (including SA2s with zero
  pop). Includes an associated change to `{hpa.spatial.data}`
  [commit](https://github.com/healthpolicyanalysis/hpa.spatial.data/commit/b1e28f35a90af27de5078dfecfd3b43d01bc3789).

## hpa.spatial 0.2.10

- update
  [`create_child_geo()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/create_child_geo.md)
  to assign un-parented mesh blocks to the nearest polygon from
  `parent_geo`.

- update testing snaps after LHN polygon was updated on
  `{hpa.spatial.data}`.

- create vignettes.

## hpa.spatial 0.2.9

- use open-source (MIT) license.

- bug fix: when creating a correspondence table and there is a complete
  match between the polygons but all meshblocks data within have
  populations of zero, allow the match with ratio = 1.

- bug fix: when using map_data_with_correspondence, avoid bug which
  converts `Date` grouping variables to numeric (use of
  `cbind.data.frame`, not `cbind`).

- workflow: add github action workflows for checking package
  (check-standard) and making a github pages website (pkgdown).

- bug fix:
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  would get confused when a vector object is used in combination with
  `.data`. Now the vector is attempted to be evaluated and if that
  errors, it accesses it from `.data`.

## hpa.spatial 0.2.8

- allow user to get Modified Monash Model data (for SA1, 2016 ed.) using
  `get_polygon(name = "mmm19")` or
  [`get_mmm19_poly()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_mmm19_poly.md).

- bug fix: pass `value_type` appropriately when `groups` are used in
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md).

- feature: let
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  take a list of vectors for groups or, when `.data` is passed, can take
  a character vector or column names or a vector of symbols.

## hpa.spatial 0.2.7

- allow
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  to take `from_geo` and `to_geo` rather than only areas and years.
  (Also requires adding `export_fname` arg, consistent with changes to
  [`get_correspondence_tbl()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_correspondence_tbl.md).)

- allow
  [`get_correspondence_tbl()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_correspondence_tbl.md)
  to take `from_geo` and `to_geo` rather than only areas and years to
  get the polygons via
  [`get_polygon()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_polygon.md).
  Also allow user to specify an `export_fname` (file name) to save the
  correspondence table for these new tables as they can’t be named with
  `make_fname()`.

## hpa.spatial 0.2.6

- make
  [`create_child_geo()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/create_child_geo.md)
  which adapts an `sf` polygon (`child_geo`) object by splitting
  polygons which span across multiple polygons within another passed
  `sf` polygon object (`parent_geo`). Can be used to adapt, for example,
  SA3s that span across multiple LHN’s so that those that cross are
  split.

- move datasets that are used to
  [hpa.spatial.data](https://github.com/healthpolicyanalysis/hpa.spatial.data)
  pkg and access them just int he same way that
  [strayr](https://runapp-aus.github.io/strayr/) reads in data from
  `{absmapsdata}`.

- properly use `export_dir` from
  [`get_polygon()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_polygon.md).

- remove all internal data and rely only on data from
  [hpa.spatial.data](https://github.com/healthpolicyanalysis/hpa.spatial.data).

## hpa.spatial 0.2.5

- move PHN_CODE to be first col of `phn` to be consistent with other pkg
  data.

## hpa.spatial 0.2.4

- use tidy evaluation on quosures to avoid problems with accessing
  objects passed to `hpa.spatial` functions that evaluate calls.

- save and read correspondence tables to save time particularly when a
  correspondence table that’s being created is being created many times
  over within
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  (say, when `groups` is being used).

## hpa.spatial 0.2.3

- bug fix: call
  [`get_correspondence_tbl()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_correspondence_tbl.md)
  from parent environment in
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md).

## hpa.spatial 0.2.2

- default mb_geo in
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  as missing and apply default within function code. Using a
  `hpa.spatial` function as a default arg fails when it’s called by
  namespace
  ([`hpa.spatial::map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)).

## hpa.spatial 0.2.1

- add
  [`get_correspondence_tbl()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_correspondence_tbl.md)
  which calls
  [`strayr::read_correspondence_tbl()`](https://runapp-aus.github.io/strayr/reference/read_correspondence_tbl.html)
  and if it fails to find one, it uses
  [`make_correspondence_tbl()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/make_correspondence_tbl.md)
  to create one. Takes the same args as
  [`strayr::read_correspondence_tbl()`](https://runapp-aus.github.io/strayr/reference/read_correspondence_tbl.html)
  but with the option to use a different mesh blocks edition/population
  data for
  [`make_correspondence_tbl()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/make_correspondence_tbl.md).

- add
  [`make_correspondence_tbl()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/make_correspondence_tbl.md)
  to create a correspondence table between two given geographies and a
  `POINT` geometry (`sf`) with population counts (`Person` as is
  standard in mesh blocks data).

- added a `.data` argument to
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  so that `codes`, `values` and `groups` can be passed by reference
  (like in
  [`dplyr::mutate()`](https://dplyr.tidyverse.org/reference/mutate.html)).

- always return a tibble from
  [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
  (just for consistency).

- add tests for (#3) which is a non-issue.

## hpa.spatial 0.2.0

- create an `lhn` dataset to replace the independent state datasets
  (`qld_hhs`, `nsw_lhd`, `sa_lhn` etc…).

- bug fix (#2): use
  [`withr::with_package()`](https://withr.r-lib.org/reference/with_package.html)
  and
  [`withr::with_environment()`](https://withr.r-lib.org/reference/with_package.html)
  to evaluate calls in
  [`get_polygon()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_polygon.md)
  with `hpa.spatial` namespace within copy of parent environment.

## hpa.spatial 0.1.1

- initial release with two main functions:

  - [`get_polygon()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/get_polygon.md)
    accesses the polygons from `{absmapsdata}` via
    [`strayr::read_absmap()`](https://runapp-aus.github.io/strayr/reference/read_absmap.html)
    as well as some other shape files internal to this pkg

  - [`map_data_with_correspondence()`](https://healthpolicyanalysis.github.io/hpa.spatial/reference/map_data_with_correspondence.md)
    allows the user to map data (unit or aggregate values) across
    between editions of the ASGS as well as up within nested levels
    (i.e. SA2 to SA3).
