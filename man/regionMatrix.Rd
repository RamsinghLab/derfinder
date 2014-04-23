\name{regionMatrix}
\alias{regionMatrix}
\title{Identify regions data by a coverage filter and get a count matrix}
\usage{
regionMatrix(fullCov, cutoff = 5, filter = "mean", maxRegionGap = 0L,
  maxClusterGap = 300L, L, verbose = TRUE)
}
\arguments{
  \item{fullCov}{A list where each element is the result
  from \link{loadCoverage} used with \code{cutoff=NULL}.
  The elements of the list should be named according to the
  chromosome number. Can be generated using
  \link{fullCoverage}.}

  \item{cutoff}{Per base pair, at least one sample has to
  have coverage strictly greater than \code{cutoff} to be
  included in the result. This argument is passed to
  \link{filterData}.}

  \item{filter}{Has to be either \code{"one"} (default) or
  \code{"mean"}. In the first case, at least one sample has
  to have coverage above \code{cutoff}. In the second case,
  the mean coverage has to be greater than \code{cutoff}.
  This argument is passed to \link{filterData}.}

  \item{maxRegionGap}{This determines the maximum number of
  gaps between two genomic positions to be considered part
  of the same candidate Differentially Expressed Region
  (candidate DER). This argument is passed to
  \link{findRegions}.}

  \item{maxClusterGap}{This determines the maximum gap
  between candidate DERs. It should be greater than
  \code{maxRegionGap}. This argument is passed to
  \link{findRegions}.}

  \item{L}{The width of the reads used. This argument is
  passed to \link{coverageToExon}.}

  \item{verbose}{If \code{TRUE} basic status updates will
  be printed along the way.}
}
\value{
A list with one entry per chromosome. Then per chromosome,
a list with two components. \describe{ \item{regions }{ A
set of regions based on the coverage filter cutoff as
returned by \link{findRegions}.} \item{coverageMatrix }{ A
matrix with the mean coverage by sample for each candidate
region.} }
}
\description{
Given a set of un-filtered coverage data (see
\link{fullCoverage}), create candidate regions by applying
a cutoff on the coverage values, and obtain a count matrix
where the number of rows corresponds to the number of
candidate regions and the number of columns corresponds to
the number of samples. The values are the mean coverage for
a given sample for a given region.
}
\details{
This function uses several other \link{derfinder-package}
functions. Inspect the code if interested.
}
\examples{
library('IRanges')
x <- Rle(round(runif(1e4, max=10)))
y <- Rle(round(runif(1e4, max=10)))
z <- Rle(round(runif(1e4, max=10)))
fullCov <- list("chr21" = DataFrame(x, y, z))
regionMat <- regionMatrix(fullCov = fullCov, maxRegionGap = 10L,
    maxClusterGap = 300L, L = 36)
}
\author{
Leonardo Collado-Torres
}
