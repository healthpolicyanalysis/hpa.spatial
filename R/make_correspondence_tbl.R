#' Create a correspondence table between any two geographies.
#'
#'
#' @param from_geo an \code{{sf}} POLYGON object.
#' @param to_geo an \code{{sf}} POLYGON object.
#' @param mb_geo an \code{{sf}} POINT object where the points are the centroids
#' of a small area (intended to be mesh blocks but can be any other space that's
#' small enough to be useful. Should also include a column, \code{Person},
#' with the population within that area.
#'
#' @return a \code{tibble}.
#' @export
make_correspondence_tbl <- function(from_geo, to_geo, mb_geo) {
  mb_geo <- mb_geo |>
    dplyr::select(mb_code = 1, pop = Person) |>
    dplyr::filter(pop != 0)

  from_geo_codename <- names(from_geo)[1]
  to_geo_codename <- names(to_geo)[1]

  from_geo <- dplyr::select(from_geo, from_code = 1)
  to_geo <- dplyr::select(to_geo, to_code = 1)

  mb_geo_from <- mb_geo |>
    sf::st_join(from_geo) |>
    dplyr::as_tibble() |>
    dplyr::select(mb_code, from_code, pop)

  mb_geo_to <- mb_geo |>
    sf::st_join(to_geo) |>
    dplyr::as_tibble() |>
    dplyr::select(mb_code, to_code)

  dplyr::inner_join(mb_geo_from, mb_geo_to) |>
    dplyr::group_by(from_code, to_code) |>
    dplyr::summarize(pop_sum = sum(pop)) |>
    dplyr::ungroup() |>
    dplyr::group_by(from_code) |>
    dplyr::mutate(ratio = pop_sum / sum(pop_sum)) |>
    dplyr::select(-pop_sum) |>
    dplyr::rename(
      !!rlang::sym(from_geo_codename) := 1,
      !!rlang::sym(to_geo_codename) := 2,
    )
}
