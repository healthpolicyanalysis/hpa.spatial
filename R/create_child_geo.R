#' Create a child geography (polygon) which fits neatly into a parent geography.
#'
#'
#' @param child_geo Child geography (\code{sf} polygon or multipolygon) which
#' is to be adjusted to fit within \code{parent_geo}.
#' @param parent_geo Parent geography (\code{sf} polygon or multipolygon) which
#' the child geography is being adapted to fit within.
#' @param mb_geo Mesh blocks geography with \code{Person} column for population
#' based mapping. Defaults to use 2021 edition and census data.
#' @param mb_poly Mesh blocks polygon for dissolving within subsets of polygons
#' from \code{child_geo} that cross multiple polygons in \code{parent_geo}.
#' Defaults to use 2021 edition.
#' @param minimum_majority_portions If the child geography has more than
#' \code{minimum_majority_portions} proportion of their population within a
#' single polygon within the \code{parent_geo}, it will not be split into
#' multiple separate polygons.
#'
#' @return a \code{sf} polygon or multipolygon.
#' @export
#'
#' @examples
#' \donttest{
#' sa3 <- get_polygon("sa32016")
#' lhns <- get_polygon("LHN")
#' create_child_geo(sa3, lhns)
#' }
create_child_geo <- function(child_geo,
                             parent_geo,
                             mb_geo = get_mb21_pop(),
                             mb_poly = get_mb21_poly(),
                             minimum_majority_portions = 0.95) {
  # assert thats child/parent/mb_geo are sf polygons
  # assert that minimum majoirty_portions is 0<=x<=1

  child_geo_orig <- child_geo

  child_geo <- update_crs(child_geo, crs = sf::st_crs(mb_geo))
  parent_geo <- update_crs(parent_geo, crs = sf::st_crs(mb_geo))


  correspondence_tbl <- make_correspondence_tbl(
    from_geo = child_geo,
    to_geo = parent_geo,
    mb_geo = mb_geo
  )

  child_code_col <- names(correspondence_tbl)[1]
  parent_code_col <- names(correspondence_tbl)[2]
  mb_code_col <- names(mb_geo)[1]

  assertthat::are_equal(names(mb_geo)[1], names(mb_poly)[1])

  majority_portions <- correspondence_tbl |>
    dplyr::group_by(!!rlang::sym(child_code_col)) |>
    dplyr::summarize(max_ratio = max(ratio))

  if (all(majority_portions$max_ratio >= minimum_majority_portions)) {
    message(
      "All polygons of child geography are contained within a single ",
      "polygon of the parent geography. Returned child geography is unchanged."
    )
    return(child_geo_orig)
  }

  # browser()
  child_codes_for_splitting <- majority_portions |>
    dplyr::filter(max_ratio < minimum_majority_portions) |>
    dplyr::pull(dplyr::all_of(child_code_col))

  child_polygons_for_splitting <- child_geo |>
    dplyr::filter(!!rlang::sym(child_code_col) %in% child_codes_for_splitting)

  mb_joined <- mb_geo |>
    dplyr::select(1, Person) |>
    sf::st_filter(child_polygons_for_splitting) |>
    sf::st_join(dplyr::select(child_polygons_for_splitting, !!rlang::sym(child_code_col))) |>
    sf::st_join(dplyr::select(parent_geo, !!rlang::sym(parent_code_col)))

  if (any(is.na(mb_joined[[parent_code_col]]))) {
    message(
      "There are some polygons in the child_geo which are not contained ",
      "within the parent_geo. Assigning these to the nearest polygon in the parent_geo"
    )
    mb_nas <- mb_joined |> dplyr::filter(is.na(!!rlang::sym(parent_code_col)))
    parent_geo_code_idx <- sf::st_nearest_feature(mb_nas, parent_geo)

    mb_joined[is.na(mb_joined[[parent_code_col]]), parent_code_col] <- parent_geo[[parent_code_col]][parent_geo_code_idx]
  }


  mb_poly <- mb_poly |>
    dplyr::select(1) |>
    dplyr::inner_join(sf::st_drop_geometry(mb_joined), by = mb_code_col)


  mb_poly_agg <-
    mb_poly |>
    dplyr::group_by(!!rlang::sym(child_code_col), !!rlang::sym(parent_code_col)) |>
    dplyr::summarize(geometry = sf::st_union(geometry)) |>
    dplyr::mutate(
      !!rlang::sym(child_code_col) := paste0(
        !!rlang::sym(child_code_col),
        "-",
        LETTERS[dplyr::row_number()]
      )
    )

  non_split_polys <- correspondence_tbl |>
    dplyr::filter(Negate(`%in%`)(!!rlang::sym(child_code_col), child_polygons_for_splitting[[1]])) |>
    dplyr::group_by(!!rlang::sym(child_code_col)) |>
    dplyr::arrange(dplyr::desc(ratio)) |>
    dplyr::slice(1) |>
    dplyr::select(-ratio) |>
    (\(x) dplyr::right_join(child_geo[1], x, by = child_code_col))()

  dplyr::bind_rows(non_split_polys, mb_poly_agg) |>
    dplyr::arrange(!!rlang::sym(child_code_col))
}
