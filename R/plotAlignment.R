#' Visualize multiple sequence alignment of CDR3 sequences
#'
#' Generate MSA alignment figures from the results of alignSeq
#' @param msa An msa object obtained from alignSeq function in LymphoSeq2.
#' @return Multiple sequence alignment plot.
#' @seealso The function utilizes ggmsa package for visualizations. Further details 
#' on ggmsa can be found at the link mentioned below.
#' \url{https://cran.r-project.org/web/packages/ggmsa/vignettes/ggmsa.html}
#' @examples
#' file_path <- system.file("extdata", "IGH_sequencing", package = "LymphoSeq2")
#'
#' stable <- readImmunoSeq(path = file_path, threads = 1)
#'
#' ntable <- productiveSeq(stable, aggregate = "junction")
#'
#' msa <- alignSeq(ntable, repertoire_id = "IGH_MVQ92552A_BL", type = "junction", 
#'          method = "ClustalW")
#'
#' plotAlignment(msa)
#'
#' @export
#' @import ggmsa
plotAlignment <- function(msa) {
  msa <- msa@unmasked
  names(msa) <- purrr::map(seq_along(names(msa)), function(i) paste0(names(msa)[[i]], "_", i))
  ggmsa::ggmsa(msa, font = NULL, color = "Chemistry_NT")
}
