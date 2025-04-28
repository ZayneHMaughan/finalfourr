#' Plot Comparison Between Two Teams
#'
#' This function takes the result of \code{compare_teams()} and creates a bar
#' plot comparing #' two teams on selected offensive and defensive metrics.
#'
#' @param comparison_df A data frame returned by \code{compare_teams()},
#'     with two rows and the metrics as columns.
#'
#' @return A \code{ggplot} object showing the side-by-side comparison.
#' @name plot_compare_teams
#'
#' @export
#'
#' @examples
#' comparison <- compare_teams(2021, "Bryant", "Lamar")
#' plot_compare_teams(comparison)
utils::globalVariables(c("Metric", "Value"))
plot_compare_teams <- function(comparison_df) {
  # Check input
  if (!is.data.frame(comparison_df) || nrow(comparison_df) != 2) {
    stop("Input must be a data frame with two rows from compare_teams().")
  }

  # Load required package
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required but not installed.")
  }

  # Reshape data to long format for ggplot
  long_df <- reshape2::melt(comparison_df,
                            id.vars = "team",
                            variable.name = "Metric", value.name = "Value"
  )

  # Plot
  ggplot2::ggplot(long_df, ggplot2::aes(x = Metric, y = Value, fill = team)) +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::labs(title = "Team Comparison", x = "Metric", y = "Value") +
    ggplot2::theme_minimal() +
    ggplot2::scale_fill_brewer(palette = "Set1")
}


#' Line Plot Comparison Between Two Teams
#'
#' This function takes the result of \code{compare_teams()} and creates a line
#' plot comparing two teams across selected offensive and defensive metrics.
#'
#' @param comparison_df A data frame returned by \code{compare_teams()},
#'     containing two rows (one for each team) and the metrics as columns.
#'
#' @return A \code{ggplot} object showing the comparison as connected lines
#' across metrics.
#' @name plot_compare_teams
#' @export
#'
#' @examples
#' comparison <- compare_teams(2021, "Bryant", "Lamar")
#' plot_compare_teams_line(comparison)
utils::globalVariables(c("Metric", "Value"))
plot_compare_teams_line <- function(comparison_df) {
  if (!is.data.frame(comparison_df) || nrow(comparison_df) != 2) {
    stop("Input must be a data frame with two rows from compare_teams().")
  }

  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required but not installed.")
  }

  long_df <- reshape2::melt(comparison_df,
                            id.vars = "team",
                            variable.name = "Metric", value.name = "Value"
  )

  ggplot2::ggplot(long_df, ggplot2::aes(x = Metric, y = Value, group = team, color = team)) +
    ggplot2::geom_line(size = 1.2) +
    ggplot2::geom_point(size = 3) +
    ggplot2::labs(title = "Team Comparison (Line Chart)", x = "Metric", y = "Value") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::scale_color_brewer(palette = "Set1")
}
