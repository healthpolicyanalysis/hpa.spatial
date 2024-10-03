#' Create a correspondence table between any two geographies
#'
#'
#' @param from_geo An \code{{sf}} POLYGON object.
#' @param to_geo An \code{{sf}} POLYGON object.
#' @param mb_geo An \code{{sf}} POINT object where the points are the centroids
#' of a small area (intended to be mesh blocks but can be any other space that's
#' small enough to be useful. Should also include a column, \code{Person},
#' with the population within that area. Defaults to use Mesh Blocks (2021) and
#' with 2021 census data. See \code{get_mb21_pop()}.
#' @param ... other, ignored arguments.
#'
#' @return A \code{tibble}.
#' @export
#' @examples
#' make_correspondence_tbl(
#'   from_geo = get_polygon("sa22016", crs = 7844),
#'   to_geo = get_polygon("sa22021", crs = 7844),
#'   mb_geo = get_mb21_pop()
#' )
make_correspondence_tbl <- function(from_geo, to_geo, mb_geo = get_mb21_pop(), ...) {
  mb_geo <- mb_geo |>
    dplyr::select(mb_code = 1, pop = Person)

  from_geo_codename <- names(from_geo)[1]
  to_geo_codename <- names(to_geo)[1]

  from_geo <- remove_empty_geographies(from_geo)
  to_geo <- remove_empty_geographies(to_geo)

  from_geo <- dplyr::select(from_geo, from_code = 1)
  to_geo <- dplyr::select(to_geo, to_code = 1)

  mb_geo_from <- mb_geo |>
    sf::st_join(from_geo) |>
    dplyr::as_tibble() |>
    dplyr::select(mb_code, from_code, pop) |>
    stats::na.omit() |>
    dplyr::group_by(from_code) |>
    dplyr::mutate(empty_pop = sum(pop) == 0) |>
    dplyr::ungroup() |>
    dplyr::mutate(pop = ifelse(empty_pop, 1, pop)) |>
    dplyr::select(-empty_pop)

  mapped_from_mb_codes <- unique(mb_geo_from$from_code)

  mb_geo_to <- mb_geo |>
    sf::st_join(to_geo) |>
    dplyr::as_tibble() |>
    dplyr::select(mb_code, to_code) |>
    stats::na.omit()

  matched_geos <- dplyr::inner_join(mb_geo_from, mb_geo_to, by = "mb_code") |>
    dplyr::group_by(from_code, to_code) |>
    dplyr::summarize(pop_sum = sum(pop)) |>
    dplyr::ungroup() |>
    dplyr::group_by(from_code) |>
    dplyr::mutate(ratio = ifelse(
      dplyr::n() == 1 & pop_sum == 0,
      1,
      pop_sum / sum(pop_sum)
    )) |>
    dplyr::ungroup() |>
    dplyr::select(-pop_sum) |>
    dplyr::filter(
      ratio != 0,
      from_code %in% from_geo$from_code
    ) |>
    dplyr::rename(
      !!rlang::sym(from_geo_codename) := 1,
      !!rlang::sym(to_geo_codename) := 2,
    )

  unmatched_geos <- tibble::tibble(
    !!rlang::sym(from_geo_codename) := from_geo$from_code[!from_geo$from_code %in% matched_geos[[1]]],
    !!rlang::sym(to_geo_codename) := NA_character_,
    ratio = 1
  )

  dplyr::bind_rows(matched_geos, unmatched_geos) |>
    dplyr::arrange(1)
}


remove_empty_geographies <- function(geo, print_removed_codes = FALSE) {
  idx_empty <- sf::st_is_empty(geo)
  if (any(idx_empty)) {
    if (print_removed_codes) {
      message(glue::glue(
        "There were {sum(idx_empty)} empty geometries in the geo provided ",
        "({names(geo)[1]}). These will be removed."
      ))
      for (c in geo[[1]][idx_empty]) {
        message(c)
      }
    }
  }
  geo[!idx_empty, ]
}
