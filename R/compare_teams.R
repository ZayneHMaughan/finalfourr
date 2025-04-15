#' Compare Two Teams on Key Shooting and Defensive Metrics
#'
#' This function compares two college basketball teams from a
#' given year on their free throw rate, 2-point percentage,
#' 3-point percentage, and their defensive equivalents.
#'
#' @param year An integer year (e.g., 2018).
#' @param team1 The name of the first team (as a character string).
#' @param team2 The name of the second team (as a character string).
#' @param data A data frame containing the dataset
#'             (must include relevant columns). Defaults to \code{DATASET}.
#'
#' @return A data frame comparing the two teams across selected offensive
#'             and defensive metrics.
#' @export
#'
#' @examples
#' compare_teams(2019, "Duke", "North Carolina")
compare_teams <- function(year, team1, team2, data = DATASET) {
  validate_compare_inputs(year, team1, team2, data)

  # Filter data for the given year and the two teams
  comparison <- data[data$year == year & data$team %in% c(team1, team2),
                     c("team", "ftr", "two_pt_pct", "three_pt_pct",
                       "def_ftr.y", "def_two_pt_pct", "def_three_pt_pct")]

  # Return comparison sorted by input order
  comparison[match(c(team1, team2), comparison$team), ]
}
