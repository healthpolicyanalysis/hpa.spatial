#' Statistical Areas (ASGS) to PHN area correspondence data.
#'
#'
#' @format ## `sa_phn_correspondence_tables`
#'
#' A \code{list} of \code{data.frame}s.
#'
#'
#' contains correspondence data between ASGS structures (SA1, SA2, and SA3) to PHNs across Australia.
#' @source <https://www.health.gov.au/resources/collections/primary-health-networks-phns-collection-of-concordance-files>
"sa_phn_correspondence_tables"


#' \code{data.frame} A table with mappings from SA1's to HHS in QLD.
#'
#'
#' @format ## `qld_sa1_2016_to_hhs`
#'
#' A \code{data.frame} object.
#'
#'
#' A lookup table between SA1 codes and HHS (majority contained).
#' @source <hqld_hhs and ASGS-SA1 boundaries>
"qld_sa1_2016_to_hhs"


#' \code{sf} Multipolygon data for the Primary Health Network boundaries for Australia.
#'
#'
#' @format ## `phn`
#'
#' A \code{sf} object.
#'
#'
#' shows the boundaries of the Primary Health Network in Australia.
#' @source <https://data.gov.au/dataset/ds-dga-ef2d28a4-1ed5-47d0-8e3a-46e25bc4f66b/details>
"phn"


#' \code{sf} Multipolygon data for the Local Hospital Network boundaries for Australia.
#'
#'
#' @format ## `lhn`
#'
#' A \code{sf} object.
#'
#'
#' shows the boundaries of the Local Hospital Network in Australia.
#' @source <https://hub.arcgis.com/datasets/ACSQHC::local-hospital-networks/explore>
"lhn"
