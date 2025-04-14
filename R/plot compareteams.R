#' Plot Comparison Between Two Teams
#'
#' This function takes the result of \code{compare_teams()} and creates a bar plot comparing
#' two teams on selected offensive and defensive metrics.
#'
#' @param comparison_df A data frame returned by \code{compare_teams()}, with two rows and the metrics as columns.
#'
#' @return A \code{ggplot} object showing the side-by-side comparison.
#' @export
#'
#' @examples
#' comparison <- compare_teams(2021, "Bryant", "Lamar")
#' plot_team_comparison(comparison)
plot_team_comparison <- function(comparison_df) {
  # Check input
  if (!is.data.frame(comparison_df) || nrow(comparison_df) != 2) {
    stop("Input must be a data frame with two rows from compare_teams().")
  }

  # Load required package
  if (!requireNamespace("ggplot2", quietly = TRUE)) {
    stop("Package 'ggplot2' is required but not installed.")
  }

  # Reshape data to long format for ggplot
  long_df <- reshape2::melt(comparison_df, id.vars = "team", variable.name = "Metric", value.name = "Value")

  # Plot
  ggplot2::ggplot(long_df, ggplot2::aes(x = Metric, y = Value, fill = team)) +
    ggplot2::geom_bar(stat = "identity", position = "dodge") +
    ggplot2::labs(title = "Team Comparison", x = "Metric", y = "Value") +
    ggplot2::theme_minimal() +
    ggplot2::scale_fill_brewer(palette = "Set1")
}
