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
#' @name plot_compare_teams_line
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
  if (!requireNamespace("reshape2", quietly = TRUE)) {
    stop("Package 'reshape2' is required but not installed.")
  }

  long_df <- reshape2::melt(comparison_df,
                            id.vars = "team",
                            variable.name = "Metric", value.name = "Value")

  # Split into More is Better and Less is Better
  metrics_more <- unique(long_df$Metric)[1:3]
  metrics_less <- unique(long_df$Metric)[4:6]

  df_more <- long_df[long_df$Metric %in% metrics_more, ]
  df_less <- long_df[long_df$Metric %in% metrics_less, ]

  p_more <- ggplot2::ggplot(df_more, ggplot2::aes(x = Metric, y = Value, group = team, color = team)) +
    ggplot2::geom_line(size = 1.2) +
    ggplot2::geom_point(size = 3) +
    ggplot2::labs(title = "Team Comparison (More is Better)", x = "Metric", y = "Value") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::scale_color_brewer(palette = "Set1")

  p_less <- ggplot2::ggplot(df_less, ggplot2::aes(x = Metric, y = Value, group = team, color = team)) +
    ggplot2::geom_line(size = 1.2) +
    ggplot2::geom_point(size = 3) +
    ggplot2::labs(title = "Team Comparison (Less is Better)", x = "Metric", y = "Value") +
    ggplot2::theme_minimal() +
    ggplot2::theme(axis.text.x = ggplot2::element_text(angle = 45, hjust = 1)) +
    ggplot2::scale_color_brewer(palette = "Set1")

  return(list(more_is_better = p_more, less_is_better = p_less))
}
