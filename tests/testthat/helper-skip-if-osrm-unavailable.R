skip_if_osrm_unavailable <- function(osrm.server = getOption("osrm.server", "https://routing.openstreetmap.de/")) {
  ok <- tryCatch(
    {
      osrm::osrmTable(
        src = matrix(c(13.38, 52.52), ncol = 2, dimnames = list(NULL, c("lon", "lat"))),
        measure = "duration",
        osrm.server = osrm.server
      )
      TRUE
    },
    error = function(e) FALSE
  )
  if (!ok) testthat::skip("OSRM routing server is unavailable")
}
