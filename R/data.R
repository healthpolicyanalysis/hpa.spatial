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


#' \code{sf} Multipolygon data for the hospital and health service boundaries within Queensland.
#'
#'
#' @format ## `qld_hhs`
#'
#' A \code{sf} object.
#'
#'
#' shows the boundaries of the hospital and health services in Queensland.
#' @source <https://qldspatial.information.qld.gov.au/catalogue/custom/detail.page?fid={A4661F6D-0013-46EE-A446-A45F01A64D46}>
"qld_hhs"


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


#' \code{sf} Multipolygon data for the local hospital network boundaries within South Australia.
#'
#'
#' @format ## `sa_lhn`
#'
#' A \code{sf} object.
#'
#'
#' shows the boundaries of the local hospital network in SA.
#' @source <https://data.gov.au/dataset/ds-sa-120bdc9e-1c96-4ea5-b98c-aa148bb33a10/details?q=primary%20health%20network>
"sa_lhn"


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
