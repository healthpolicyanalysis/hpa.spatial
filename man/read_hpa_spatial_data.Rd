% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/read_hpa_spatial_data.R
\name{read_hpa_spatial_data}
\alias{read_hpa_spatial_data}
\title{Read a dataset from <github.com/healthpolicyanalysis/hpa.spatial.data/>}
\usage{
read_hpa_spatial_data(name, export_dir = tempdir())
}
\arguments{
\item{name}{The name of dataset in \code{hpa.spatial.data} repo.
Valid names are those within \code{get_data_file_list()}.}

\item{export_dir}{The directory to store the downloaded data.}
}
\value{
An \code{sf} object.
}
\description{
Read a dataset from <github.com/healthpolicyanalysis/hpa.spatial.data/>
}
\examples{
read_hpa_spatial_data("lhn")
}
