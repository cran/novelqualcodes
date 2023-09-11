## ---- include = FALSE---------------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>",
  fig.width = 7,
  fig.height = 4
)

## ----eval=FALSE---------------------------------------------------------------
#  install.packages("novelqualcodes")

## ----eval=FALSE---------------------------------------------------------------
#  library(novelqualcodes)

## ----eval=FALSE---------------------------------------------------------------
#  create_field_notes_template("C:/path/to/save/this/to")

## -----------------------------------------------------------------------------
library(novelqualcodes)

## ----fake_import_fieldnotes, eval=FALSE---------------------------------------
#  my_refinements <- import_field_notes(path = "C:/insect_study/records/refinements.xlsx")

## ----real_import_fieldnotes, echo=FALSE---------------------------------------
# This is the chunk that actually imports the files that are included with the
# package. 
my_refinements <- 
    import_field_notes(system.file("insect_study/records/refinements.xlsx", 
                                   package = "novelqualcodes"))

## ----fake_import_mats, eval=FALSE---------------------------------------------
#  nvivo_matrices <- import_coding_matrices(path = "C:/insect_study/matrices")
#  
#  #> ( 1 / 15) Reading Int01_ID731.xlsx
#  #> ( 2 / 15) Reading Int02_ID121.xlsx
#  #> ( 3 / 15) Reading Int03_ID54.xlsx
#  #> ( 4 / 15) Reading Int04_ID31.xlsx
#  #> ( 5 / 15) Reading Int05_ID33.xlsx
#  #> ( 6 / 15) Reading Int06_ID12.xlsx
#  #> ( 7 / 15) Reading Int07_ID17.xlsx
#  #> ( 8 / 15) Reading Int08_ID85.xlsx
#  #> ( 9 / 15) Reading Int09_ID77.xlsx
#  #> (10 / 15) Reading Int10_ID32.xlsx
#  #> (11 / 15) Reading Int11_ID21.xlsx
#  #> (12 / 15) Reading Int12_ID72.xlsx
#  #> (13 / 15) Reading Int13_ID14.xlsx
#  #> (14 / 15) Reading Int14_ID18.xlsx
#  #> (15 / 15) Reading Int15_ID112.xlsx
#  
#  #> 15 files were read.

## ----real_import_mats, echo=FALSE, message=FALSE, warning=FALSE---------------
nvivo_matrices <- 
    import_coding_matrices(system.file("insect_study/matrices/", 
                                       package = "novelqualcodes"))

## -----------------------------------------------------------------------------
code_results <- score_codes(nvivo_matrices)

## -----------------------------------------------------------------------------
print(code_results)

## -----------------------------------------------------------------------------
plot_novelty(score_df = code_results, refinements = my_refinements)

## -----------------------------------------------------------------------------
plot_novelty(score_df = code_results)

## -----------------------------------------------------------------------------
plot_novelty(score_df = code_results, refinements = c(4, 8, 10))

## ----eval=FALSE---------------------------------------------------------------
#  save_last_plot(filename = "C:/insect_study/plots/novelty.png",
#                 size = "10 x 5 cm", dpi = 300)

## -----------------------------------------------------------------------------
plot_richness(score_df = code_results, refinements = my_refinements)

## -----------------------------------------------------------------------------
plot_richness(score_df = code_results)

## -----------------------------------------------------------------------------
plot_richness(score_df = code_results, refinements = c(4, 8, 10))

## ----eval=FALSE---------------------------------------------------------------
#  ?novelqualcodes
#  
#  ?import_field_notes
#  ?import_coding_matrices
#  ?score_codes
#  ?plot_novelty
#  ?plot_richness

