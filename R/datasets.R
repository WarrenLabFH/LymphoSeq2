#' publishedTRB 
#'
#' A database of unique productive T cell receptor beta CDR3
#' amino acid sequences with known antigen specificity.
#'
#' @format A dataframe with 9,606 rows and 6 columns corresponding amino acid sequence,
#' PubMed ID (PMID), HLA type, antigen specificity, epitope, and % prevalence
#' that the sequence appeared within the peripheral blood of 55 healthy individuals.
#' 
#' @source Antigen specific T cell receptor beta sequences were manual curated
#' from published studies with help from Edus H. Warren, Andrea Towlerton,
#' Steve House, and Will DeWitt. Approximatley 5900 sequences were downloaded
#' from VDJserver <https://vdjdb.cdr3.net>.
"prevalenceTRB"

#' prevalenceTRB
#'
#' A database of unique productive T cell receptor beta CDR3 amino acid sequences
#' from the peripheral blood of 55 healthy individuals, age range 0-90 years.
#'
#' @format A dataframe with 11,724,292 rows and 2 columns. The first column corresponds to
#' T cell receptor beta CDR3 amino acid sequences. The second column corresponds to
#' the % frequency that the sequence appeared within the peripheral blood of 55
#' healthy individuals.
#' 
#' @source Sequencing from 39 individuals, age ranging from 0-90 years, was obtained
#' from Britanova, O. V. et al. The Journal of Immunology 2014; 192: 2689-2698
#' <http://mitcr.milaboratory.com/datasets/aging2013/>. Sequencing for the remaining
#' 16 individuals, age range from 17-67 years, was obtained from
#' "Origin and evolution of the T-cell repertoire after posttransplantation cyclophosphamide"
#' <https://clients.adaptivebiotech.com/publishedProjects>.
"publishedTRB"