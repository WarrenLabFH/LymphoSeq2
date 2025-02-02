% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/countKmer.R
\name{countKmer}
\alias{countKmer}
\title{Find k-mers and its counts}
\usage{
countKmer(study_table, k, separate = TRUE)
}
\arguments{
\item{study_table}{A tibble consisting of antigen receptor
sequencing imported by the LymphoSeq2 function readImmunoSeq.
"repertoire_id" and "junction" are required columns.}

\item{k}{The length of k-mers to find.}

\item{separate}{A boolean value. TRUE to separate the counts of each k-mer
by repertoire_ids. FALSE to show cumulative counts instead.
Default value is TRUE.}
}
\value{
A tibble with the k-mer and its counts. The counts can be cumulative
counts of the entire study_table or counts for each repertoire_id.
}
\description{
Calculate counts of kmers in the query nucleotide sequence
}
\examples{
file_path <- system.file("extdata", "TCRB_sequencing", package = "LymphoSeq2")

stable <- readImmunoSeq(path = file_path)

kmer_table <- countKmer(study_table = stable, k = 5, separate = TRUE)

}
