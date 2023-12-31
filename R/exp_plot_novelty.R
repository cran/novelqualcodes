
#' Plot novelty of interviews over time
#'
#' @description
#' Novel codes are information that has not been previously mentioned by other
#' interviewees. The trend of 'novel' interview codes provides insight into the
#' richness of qualitative information.
#'
#' This plot shows the trend of novel code generation; in the most basic way,
#' the higher the number, the richer the information that has been generated in
#' the study. By showing novel codes in context with any refinements to the
#' questions, it also shows how that trend may have been affected by those
#' refinements, and whether novel code generation is plateauing.
#'
#' This chart alone should not be used to decide on a stopping point because it
#' does not show the richness of individual interviews; some interviews are richer
#' than others, therefore consider also using [plot_richness()] to look at the
#' richness of each interview in terms of novel and duplicate codes.
#'
#' @param score_df (Dataframe) A dataframe of scored codes, as generated by [score_codes()].
#' @param refinements Either a list object generated by [import_field_notes()],
#'    or an Integer vector that lists when (in terms of interview sequence)
#'    refinements were made to the interview questions. For example, `c(10, 15)`
#'    means that interview questions were revised twice: First **before** the
#'    10th interview, and then again **before** the 15th interview.
#' @param col (List) A List containing named Character vectors. Accepted names are:
#'    - `stroke` is the colour of point outlines as well as the line linking points together.
#'    - `fill_ref` is the colour of points after a refinement.
#'    - `fill` is the fill colour of points were no refinements were made.
#'
#' @return A ggplot object.
#' @export
#'
#' @md
#'
#' @examples
#' # Field notes and coding matrices included with the package
#' path_to_notes    <- system.file("insect_study/records/refinements.xlsx", package = "novelqualcodes")
#' path_to_matrices <- system.file("insect_study/matrices/", package = "novelqualcodes")
#'
#' # Import the data
#' my_refinements <- import_field_notes(path_to_notes)
#' my_matrices    <- import_coding_matrices(path_to_matrices)
#'
#' # Score novel and duplicate codes
#' my_scores <- score_codes(my_matrices)
#'
#' # Generate a plot with no refinements
#' plot_novelty(score_df = my_scores)
#'
#' # Generate a plot using scored codes and imported refinements
#' plot_novelty(score_df = my_scores, refinements = my_refinements)
#'
#' # Generate a plot using scored codes and a vector of refinement times
#' plot_novelty(score_df = my_scores, refinements = c(4, 8, 10))
#'
#' @seealso [score_codes()], [import_field_notes()], [plot_richness()], [save_last_plot()]
#'
#' @importFrom ggplot2 .data
plot_novelty <- function(score_df, refinements = integer(0), col = list(stroke = "black", fill_ref = "black", fill = "grey80")) {
    if ("field_notes" %in% class(refinements)) {
        refinements <- refinements$ref_points
    }

    plot_df <- reshape_for_plots(score_df, refinements)
    plot_df <- plot_df[plot_df$Code == "Novel", ]
    plot_df$mark_refinement <- plot_df$Interview %in% refinements


    annotate_refinements <- list(
        ggplot2::geom_vline(xintercept = refinements,
                            linetype   = "dashed",
                            colour     = "gray50"))

    ggplot2::ggplot(plot_df,
                    ggplot2::aes(x = .data$Interview, y = .data$CumSum, group = .data$Refinement)) +
        ggplot2::theme_bw() +
        ggplot2::theme(panel.grid.minor   = ggplot2::element_blank(),
                       panel.grid.major.x = ggplot2::element_blank()) +
        annotate_refinements +
        ggplot2::geom_line(linewidth = 1, colour = col$stroke) +
        ggplot2::geom_point(ggplot2::aes(fill = .data$mark_refinement),
                            size = 2, shape = 21, colour = col$stroke) +
        ggplot2::scale_fill_manual(values = c(`TRUE`  = col$fill_ref,
                                              `FALSE` = col$fill)) +
        ggplot2::scale_y_continuous(breaks = function(x) round(unique(pretty(x)))) +
        ggplot2::theme(legend.position = "none") +
        ggplot2::ylab("Cumulative sum of novel interview codes") +
        ggplot2::xlab("Interview order\n(Refinements indicated by dashed lines)")
}
