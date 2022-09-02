context("Count k-mers in nucleotide sequence")
library(LymphoSeq2)

test_that("Number of k-mers are counted correctly", {
    junction <- "ATCGATCAC"
    study_table <- tibble::tibble(junction)
    ktable <- LymphoSeq2::countKmer(study_table = study_table, k = 3)
    num_rows <- base::nrow(ktable)
    Kmer <- c("ATC", "TCG", "CGA", "GAT", "TCA", "CAC")
    Count <- c(2, 1, 1, 1, 1, 1)
    kmer_table <- tibble::tibble(Kmer, Count)
    expect_equal(num_rows, 6)
    expect_equal(ktable, kmer_table)
})

test_that("K-mer counts are correctly sorted by repertoire_id", {
    junction <- c("ATCGATCAC", "GCTAACGTA")
    repertoire_id <- c("rep_1", "rep_2")
    study_table <- tibble::tibble(junction, repertoire_id)
    ktable <- LymphoSeq2::countKmer(study_table = study_table, k = 3, separate = TRUE)
    Kmer <- c("AAC", "ACG", "ATC", "CAC", "CGA", "CGT", "CTA", "GAT", "GCT", "GTA", "TAA", "TCA", "TCG")
    rep_1 <- c(0L, 0L, 2L, 1L, 1L, 0L, 0L, 1L, 0L, 0L, 0L, 1L, 1L)
    rep_2 <- c(1L, 1L, 0L, 0L, 0L, 1L, 1L, 0L, 1L, 1L, 1L, 0L, 0L)
    kmer_table <- tibble::tibble(Kmer, rep_1, rep_2)
    expect_true(dplyr::all_equal(ktable, kmer_table))
})