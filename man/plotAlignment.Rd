% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/plotAlignment.R
\name{plotAlignment}
\alias{plotAlignment}
\title{Visualize multiple sequence alignment of CDR3 sequences}
\usage{
plotAlignment(msa)
}
\arguments{
\item{msa}{An msa object obtained from alignSeq function in LymphoSeq2.}
}
\value{
Multiple sequence alignment plot.
}
\description{
Generate MSA alignment figures from the results of alignSeq
}
\examples{
file_path <- system.file("extdata", "IGH_sequencing", package = "LymphoSeq2")

stable <- readImmunoSeq(path = file_path)

ntable <- productiveSeq(stable, aggregate = "junction")

msa <- alignSeq(ntable, repertoire_id = "IGH_MVQ92552A_BL", type = "junction", 
         method = "ClustalW")

}
\seealso{
The function utilizes ggmsa package for visualizations. Further details
on ggmsa can be found at the link mentioned below.
\url{https://cran.r-project.org/web/packages/ggmsa/vignettes/ggmsa.html}
}
