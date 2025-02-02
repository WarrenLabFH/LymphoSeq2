% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/scoringMatrix.R
\name{bhattacharyyaCoefficient}
\alias{bhattacharyyaCoefficient}
\title{Bhattacharyya coefficient}
\usage{
bhattacharyyaCoefficient(sample_list)
}
\arguments{
\item{sample_list}{A list of two tibble corresponding derived from the productiveSeq
function in LymphoSeq2. \code{duplicate_frequency}, \code{junction_aa}, and \code{repertoire_id} columns are necessary
for the calcualtion of the Bhattacharyya coefficient.}
}
\value{
A tibble with one row and three columns sample1, sample2, bhattacharyyaCoefficient
}
\description{
Calculates the Bhattacharyya coefficient of two samples.
}
\examples{
<<<<<<< HEAD
file_path <- system.file("extdata", "TCRB_sequencing", 
 package = "LymphoSeq2")
=======
file_path <- system.file("extdata", "TCRB_sequencing", package = "LymphoSeq2")
>>>>>>> 8c93adc60131706d11b3a560be853bb3173513c5

stable <- readImmunoSeq(path = file_path)

atable <- productiveSeq(stable, aggregate = "junction_aa")

}
\seealso{
\code{\link{scoringMatrix}}
}
