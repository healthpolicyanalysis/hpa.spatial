test_that("osrm_table_pairs returns correct duration/distance per pair, including repeated points", {
  origins_sf <- sf::st_as_sf(
    data.frame(lon = c(13.38, 13.40, 13.38), lat = c(52.52, 52.50, 52.52)),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations_sf <- sf::st_as_sf(
    data.frame(lon = c(13.41, 13.39, 13.45), lat = c(52.53, 52.51, 52.50)),
    coords = c("lon", "lat"), crs = 4326
  )

  res <- osrm_table_pairs(origins_sf, destinations_sf, measure = c("duration", "distance"))

  expect_s3_class(res, "tbl_df")
  expect_equal(nrow(res), 3)
  expect_named(
    res,
    c(
      "origin_id", "origin_lon", "origin_lat",
      "destination_id", "destination_lon", "destination_lat",
      "duration", "distance"
    )
  )

  full <- osrm::osrmTable(
    src = unique(sf::st_coordinates(origins_sf)),
    dst = unique(sf::st_coordinates(destinations_sf)),
    measure = c("duration", "distance")
  )

  # row 1 and row 3 share the same origin (deduplicated internally)
  expect_equal(res$duration[1], full$durations[1, 1])
  expect_equal(res$duration[2], full$durations[2, 2])
  expect_equal(res$duration[3], full$durations[1, 3])

  expect_equal(res$distance[1], full$distances[1, 1])
  expect_equal(res$distance[2], full$distances[2, 2])
  expect_equal(res$distance[3], full$distances[1, 3])
})

test_that("osrm_table_pairs works with sfc point inputs", {
  origins_sf <- sf::st_as_sf(
    data.frame(lon = c(13.38, 13.40), lat = c(52.52, 52.50)),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations_sf <- sf::st_as_sf(
    data.frame(lon = c(13.41, 13.39), lat = c(52.53, 52.51)),
    coords = c("lon", "lat"), crs = 4326
  )

  res <- osrm_table_pairs(
    sf::st_geometry(origins_sf),
    sf::st_geometry(destinations_sf),
    measure = "duration"
  )

  expect_equal(nrow(res), 2)
  expect_true(all(res$duration > 0))
})

test_that("osrm_table_pairs errors on mismatched pair lengths", {
  origins <- sf::st_as_sf(
    data.frame(lon = 13.38, lat = 52.52),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations <- sf::st_as_sf(
    data.frame(lon = c(13.41, 13.39), lat = c(52.53, 52.51)),
    coords = c("lon", "lat"), crs = 4326
  )

  expect_error(
    osrm_table_pairs(origins, destinations),
    "same number of rows"
  )
})

test_that("osrm_table_pairs errors on unsupported input types", {
  destinations <- sf::st_as_sf(
    data.frame(lon = 13.41, lat = 52.53),
    coords = c("lon", "lat"), crs = 4326
  )

  expect_error(
    osrm_table_pairs(list(lon = 13.38, lat = 52.52), destinations),
    "must be an sf or sfc object"
  )
  expect_error(
    osrm_table_pairs(
      data.frame(lon = 13.38, lat = 52.52),
      destinations
    ),
    "must be an sf or sfc object"
  )
})

test_that("osrm_table_pairs avoids requesting the full origins x destinations grid", {
  # 4 distinct origins (A, B, C, D) paired with 2 distinct destinations
  # (X, X, Y, Y). A single full-grid request would be 4 x 2 = 8 cells.
  # Grouping by destination (the side with fewer unique points) should
  # instead issue 2 calls, each covering only 2 cells.
  origins <- sf::st_as_sf(
    data.frame(lon = c(1, 2, 3, 4), lat = c(1, 2, 3, 4)),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations <- sf::st_as_sf(
    data.frame(lon = c(10, 10, 20, 20), lat = c(10, 10, 20, 20)),
    coords = c("lon", "lat"), crs = 4326
  )

  calls <- list()
  fake_osrmTable <- function(src, dst, measure = "duration", ...) {
    calls[[length(calls) + 1]] <<- list(n_src = nrow(src), n_dst = nrow(dst))
    n_src <- nrow(src)
    n_dst <- nrow(dst)
    list(
      durations = matrix(1, nrow = n_src, ncol = n_dst),
      distances = matrix(1, nrow = n_src, ncol = n_dst)
    )
  }

  local_mocked_bindings(osrmTable = fake_osrmTable, .package = "osrm")

  res <- osrm_table_pairs(origins, destinations, measure = c("duration", "distance"))

  expect_equal(nrow(res), 4)
  expect_length(calls, 2)
  for (call in calls) {
    expect_equal(call$n_src * call$n_dst, 2)
  }
})

test_that("osrm_table_pairs adds an SSL/curl hint when osrmTable fails with an SSL error", {
  origins <- sf::st_as_sf(
    data.frame(lon = 13.38, lat = 52.52),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations <- sf::st_as_sf(
    data.frame(lon = 13.41, lat = 52.53),
    coords = c("lon", "lat"), crs = 4326
  )

  fake_osrmTable <- function(...) {
    stop("SSL certificate problem: unable to get local issuer certificate")
  }
  local_mocked_bindings(osrmTable = fake_osrmTable, .package = "osrm")

  expect_warning(
    res <- osrm_table_pairs(origins, destinations),
    "CURL_SSL_BACKEND"
  )
  expect_true(is.na(res$duration))
})

test_that("osrm_table_pairs passes through unrelated osrmTable errors unchanged", {
  origins <- sf::st_as_sf(
    data.frame(lon = 13.38, lat = 52.52),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations <- sf::st_as_sf(
    data.frame(lon = 13.41, lat = 52.53),
    coords = c("lon", "lat"), crs = 4326
  )

  fake_osrmTable <- function(...) {
    stop("HTTP error 429: Too Many Requests")
  }
  local_mocked_bindings(osrmTable = fake_osrmTable, .package = "osrm")

  w <- expect_warning(res <- osrm_table_pairs(origins, destinations))
  expect_match(conditionMessage(w), "Too Many Requests", fixed = TRUE)
  expect_false(grepl("CURL_SSL_BACKEND", conditionMessage(w), fixed = TRUE))
  expect_true(is.na(res$duration))
})

test_that("osrm_table_pairs retries once, then returns NA and warns for pairs that keep failing", {
  origins <- sf::st_as_sf(
    data.frame(lon = c(13.38, 13.40), lat = c(52.52, 52.50)),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations <- sf::st_as_sf(
    data.frame(lon = c(13.41, 13.39), lat = c(52.53, 52.51)),
    coords = c("lon", "lat"), crs = 4326
  )

  n_calls <- 0L
  fake_osrmTable <- function(src, dst, measure = "duration", ...) {
    n_calls <<- n_calls + 1L
    if (isTRUE(all.equal(src$lon[1], 13.40))) {
      stop("HTTP error 500: Internal Server Error")
    }
    list(
      durations = matrix(5, nrow = nrow(src), ncol = nrow(dst)),
      distances = matrix(5000, nrow = nrow(src), ncol = nrow(dst))
    )
  }
  local_mocked_bindings(osrmTable = fake_osrmTable, .package = "osrm")

  expect_warning(
    res <- osrm_table_pairs(origins, destinations, measure = c("duration", "distance")),
    "1 of 2"
  )

  # the failing group is retried once (2 calls) in addition to the
  # succeeding group's single call
  expect_equal(n_calls, 3L)

  expect_equal(res$duration[1], 5)
  expect_equal(res$distance[1], 5000)
  expect_true(is.na(res$duration[2]))
  expect_true(is.na(res$distance[2]))
})

test_that("osrm_table_pairs errors on mismatched CRS", {
  origins <- sf::st_as_sf(
    data.frame(lon = 13.38, lat = 52.52),
    coords = c("lon", "lat"), crs = 4326
  )
  destinations <- sf::st_as_sf(
    data.frame(lon = 13.41, lat = 52.53),
    coords = c("lon", "lat"), crs = 3857
  )

  expect_error(
    osrm_table_pairs(origins, destinations),
    "same CRS"
  )
})
