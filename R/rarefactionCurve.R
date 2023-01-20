#' Plot rarefication and extrapolation curves for samples
#' 
#' Given a study table, for each sample plot rarefaction curves to estimate 
#' repertoire diversity. The method used to generate the rarefaction curve
#' is from the vegan library.
#'
#' @param study_table A tibble consisting antigen receptor sequencing
#' data imported by the LymphoSeq2 function readImmunoSeq. "junction_aa",
#' "duplicate_count", and "duplicate_frequency" are required columns.
#' @examples
#' file_path <- system.file("extdata", "TCRB_sequencing", package = "LymphoSeq2")
#' stable <- readImmunoSeq(path = file_path, threads = 1)
#' plotRarefactionCurve(stable)
#'
#' @import magrittr
#' @export
plotRarefactionCurve <- function(study_table) {
    rarefaction_table <- study_table %>% 
                            dplyr::group_by(junction_aa, repertoire_id) %>%
                            dplyr::summarise(duplicate_count = sum(duplicate_count)) %>%
                            tidyr::pivot_wider(names_from = "junction_aa",
                                               values_from = "duplicate_count",
                                               values_fill = 0) %>%
                            as.data.frame()
    rownames(rarefaction_table) <- rarefaction_table$repertoire_id
    rarefaction_table <- rarefaction_table %>%
                            dplyr::select(-repertoire_id)

    rarefaction_curves <- vegan::rarecurve(rarefaction_table)
    names(rarefaction_curves) <- rownames(rarefaction_table)

    rarefaction_long <- mapply(FUN = function(x, y) {
        mydf <- as.data.frame(x)
        colnames(mydf) <- "value"
        mydf$species <- y
        mydf$subsample <- attr(x, "Subsample")
        mydf
    }, x = rarefaction_curves, y = as.list(names(rarefaction_curves)), SIMPLIFY = FALSE)

    xy <- do.call(rbind, rarefaction_long)
    rownames(xy) <- NULL

    curve_plot <- ggplot2::ggplot(xy, ggplot2::aes(x = subsample, y = value, color = species)) +
                    ggplot2::geom_line(size = 1.5) +
                    ggplot2::theme_classic() +
                    ggplot2::xlab("Total number of sequences") +
                    ggplot2::ylab("TCR diversity")
    return(curve_plot)
}