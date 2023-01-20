context("Check if summary statistics for dataset are correct")
library(LymphoSeq2)


test_that("Check if summary statistics for test data are correct", {
  stable <- LymphoSeq2::readImmunoSeq(path = "test_data/015V06013979_CFAR.tsv", threads = 1)
  ctable <- LymphoSeq2::clonality(stable)
  ttseq <- ctable %>%
           dplyr::pull(total_sequences)
  tupseq <- ctable %>%
            dplyr::pull(unique_productive_sequences)
  ttcount <- ctable %>% 
             dplyr::pull(total_count)
  tclonality <- ctable %>%
                dplyr::pull(clonality)
  tgc <- ctable %>% 
         dplyr::pull(gini_coefficient)
  ttps <- ctable %>%
          dplyr::pull(top_productive_sequence)
  expect_equal(ttseq, 267)
  expect_equal(tupseq, 267)
  expect_equal(ttcount, 16645)
  expect_equal(base::round(tclonality, 3), 0.388)
  expect_equal(base::round(tgc, 3), 0.901)
  expect_equal(base::round(ttps, 3), 18.522)
})
