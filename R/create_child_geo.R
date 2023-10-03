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

  mb_joined |>
    dplyr::group_by(!!rlang::sym(child_code_col), !!rlang::sym(parent_code_col)) |>
    summarize(geometry = st_combine(geometry))

}

get_mb21_poly <- function() {
  sf::sf_read("")
}
