#' Create phylogenetic tree
#'
#' Create a phylogenetic tree using neighbor joining tree estimation for amino
#' acid or junction CDR3 sequences in a list of data frames.
#'
#' @param study_table A tibble of unproductive junction sequences or productive
#' junction sequences generated by the LymphoSeq2 function [productiveSeq()].
#' "v_family", "d_family", "j_family", and "duplicate_count" are required
#' columns.
#' @param repertoire_ids A character vector indicating the name of the
#' repertoire_id in the study table.
#' @param type A character vector indicating whether `"junction_aa"` or 
#' `"junction"` (the default) sequences should be compared. 
#' @param layout A character vector indicating the tree layout. Options include
#' `"rectangular"` (the default), `"slanted"`, `"fan"`, `"circular"`, `"radial"`
#' and `"unrooted"`.
#' @param label A Boolean value
#'  * `TRUE` (the default): use sequencing duplicate_count to label the tree
#'  * `FALSE` : do not show duplicate_count
#' @return Returns a phylogenetic tree where each leaf represents a sequence
#' color coded by the V, D, and J gene usage. The number next to each leaf
#' refers to the sequence duplicate_count. A triangle shaped leaf indicates the
#' dominant sequence. Refer to the ggtree Bioconductor package documentation for
#' details on how to manipulate the tree.
#' @examples
#' file_path <- system.file("extdata", "IGH_sequencing", package = "LymphoSeq2")
#' study_table <- LymphoSeq2::readImmunoSeq(path = file_path) %>% 
#' LymphoSeq2::topSeqs(top = 100)
#' nucleotide_table <- LymphoSeq2::productiveSeq(
#'   study_table = study_table,
#'   aggregate = "junction"
#' )
#' LymphoSeq2::phyloTree(
#'   study_table = nucleotide_table, repertoire_ids = "IGH_MVQ92552A_BL",
#'   type = "junction", layout = "rectangular"
#' )
#' LymphoSeq2::phyloTree(
#'   study_table = nucleotide_table, repertoire_ids = "IGH_MVQ92552A_BL",
#'   type = "junction_aa", layout = "circular"
#' )
#' # Add scale and title to figure
#' LymphoSeq2::phyloTree(
#'   study_table = nucleotide_table, repertoire_ids = "IGH_MVQ92552A_BL",
#'   type = "junction_aa", layout = "rectangular"
#' ) +
#'   ggtree::theme_tree2() +
#'   ggplot2::theme(
#'     legend.position = "right",
#'     legend.key = ggplot2::element_rect(colour = "white")
#'   ) +
#'   ggplot2::ggtitle("Title")
#' # Hide legend and leaf labels
#' LymphoSeq2::phyloTree(
#'   study_table = nucleotide_table, repertoire_ids = "IGH_MVQ92552A_BL",
#'   type = "junction", layout = "rectangular", label = FALSE
#' ) +
#'   ggplot2::theme(legend.position = "none")
#' @importFrom ggtree "%<+%"
#' @import magrittr
#' @export
phyloTree <- function(study_table, repertoire_ids, type = "junction",
                      layout = "rectangular", label = TRUE) {
  sample_table <- study_table %>%
    dplyr::filter(repertoire_id == repertoire_ids)
  if (base::nrow(study_table) < 3) {
    stop("Cannot draw phlogenetic tree with less than 3 sequences.", call. = FALSE)
  }
  if (type == "junction") {
    sample_table <- sample_table %>%
      dplyr::filter(base::nchar(junction) >= 9)
    distance <- utils::adist(sample_table$junction, sample_table$junction)
    colnames(distance) <- rownames(distance) <- sample_table$junction
    names <- sample_table$junction
  }
  if (type == "junction_aa") {
    sample_table <- sample_table %>%
      dplyr::filter(base::nchar(junction_aa) >= 9)
    distance <- utils::adist(sample_table$junction_aa, sample_table$junction_aa)
    colnames(distance) <- rownames(distance) <- sample_table$junction_aa
    names <- sample_table$junction_aa
  }
  tree <- phangorn::NJ(distance)
  geneFamilies <- sample_table %>%
    dplyr::mutate(
      v_family = stringr::str_replace(v_family, "IGH|IGL|IGK|TCRB|TCRA", ""),
      v_family = stringr::str_replace(v_family, "unresolved", "UNR"),
      v_family = stringr::str_replace_na(v_family, "UNR"),
      d_family = stringr::str_replace(d_family, "IGH|IGL|IGK|TCRB|TCRA", ""),
      d_family = stringr::str_replace(d_family, "unresolved", "UNR"),
      d_family = stringr::str_replace_na(d_family, "UNR"),
      j_family = stringr::str_replace(j_family, "IGH|IGL|IGK|TCRB|TCRA", ""),
      j_family = stringr::str_replace(j_family, "unresolved", "UNR"),
      j_family = stringr::str_replace_na(j_family, "UNR"),
      gene_families = paste(v_family, d_family, j_family)
    ) %>%
    dplyr::pull(gene_families)
  tree_annotation <- tibble::tibble(
    names = names,
    duplicate_count = sample_table$duplicate_count,
    geneFamilies = geneFamilies,
    junction_aa = sample_table$junction_aa,
    duplicate_frequency = base::round(sample_table$duplicate_frequency, 
                                      digits = 2),
    dominant = c("Yes", rep("No", base::nrow(sample_table) - 1))
  )
  getPalette <- grDevices::colorRampPalette(RColorBrewer::brewer.pal(9, "Set1"))
  tree_plot <- ggtree::ggtree(tree, layout = layout) %<+% tree_annotation +
    ggtree::geom_tippoint(ggplot2::aes_string(color = "geneFamilies", 
                                              shape = "dominant"), size = 3) +
    ggplot2::scale_color_manual(
      values = getPalette(length(unique(geneFamilies)))) +
    ggplot2::guides(shape = FALSE) +
    ggplot2::theme(legend.position = "bottom", 
                   legend.key = ggplot2::element_rect(colour = "white")) +
    ggplot2::labs(color = "")
  if (label == TRUE) {
    tree_plot <- tree_plot +
      ggplot2::geom_text(ggplot2::aes_string(label = "duplicate_count"),
        nudge_x = 0.5, hjust = 0, size = 2.5, na.rm = TRUE,
        check_overlap = TRUE
      )
  }
  return(tree_plot)
}
