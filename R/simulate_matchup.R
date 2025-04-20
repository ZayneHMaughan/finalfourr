utils::globalVariables(c("team", "year", "adj_o.x", "adj_d.x",
                         "adj_t", "cbb_data"))
#' Simulate a Matchup Between Two Teams
#'
#' Simulates `n_sim` games between two teams for a given year using adjusted
#' offensive and defensive metrics, estimating win probabilities and declaring
#' a predicted winner based on simulation results.
#'
#' @param team1 A character string indicating the first team.
#' @param team2 A character string indicating the second team.
#' @param input_year An integer specifying the year to filter the data.
#' @param n_sim Number of simulations to run (default is 1000).
#'
#' @return This function prints the simulation results to the console,
#' including:
#' - Number of wins for each team
#' - Win percentages
#' - The predicted winner based on the majority of wins
#'
#' @details
#' The simulation uses a basic normal distribution model to estimate scores
#' per game and calculates which team wins each simulated matchup.
#' The function also relies on `validate_compare_inputs()`to ensure teams and
#' year are valid before simulating.
#'
#' @examples
#' set.seed(387)
#' # Simulate 1000 games between Utah and Baylor in 2015
#' simulate_matchup("Utah", "Baylor", 2015)
#'
#' # Simulate only 100 games
#' simulate_matchup("Utah", "Baylor", 2022, n_sim = 100)
#'
#' @export
simulate_matchup <- function(team1, team2, input_year,
                             n_sim = 1000) {
  # validate inputs
  validate_compare_inputs(input_year, team1, team2, data = cbb_data)
  # Filter data
  teams_data <- cbb_data |>
    dplyr::filter(team %in% c(team1, team2), year == input_year) |>
    dplyr::select(team, adj_o.x, adj_d.x, adj_t)

  # Split teams
  t1 <- teams_data |>
    dplyr::filter(team == team1)
  t2 <- teams_data |>
    dplyr::filter(team == team2)

  t1_wins <- 0
  t2_wins <- 0

  # Simulation loop
  for (i in 1:n_sim) {
    possessions <- (t1$adj_t + t2$adj_t) / 2
    t1_score <- stats::rnorm(1, mean = (t1$adj_o.x * (100 - t2$adj_d.x) / 100)
                             * possessions / 100, sd = 5)
    t2_score <- stats::rnorm(1, mean = (t2$adj_o.x * (100 - t1$adj_d.x) / 100)
                             * possessions / 100, sd = 5)

    if (t1_score > t2_score) {
      t1_wins <- t1_wins + 1
    } else {
      t2_wins <- t2_wins + 1
    }
  }

  # Calculate win percentages
  t1_pct <- round(100 * t1_wins / n_sim, 1)
  t2_pct <- round(100 * t2_wins / n_sim, 1)

  # Print results with winner first
  if (t1_wins >= t2_wins) {
    cat(sprintf(
      paste0(
        "\nYear: %s\n%s vs %s\n\n%s Wins: %d (%.1f%%)\n",
        "%s Wins: %d (%.1f%%)\n\nWinner: %s\n"
      ),
      input_year, team1, team2,
      team1, t1_wins, t1_pct,
      team2, t2_wins, t2_pct,
      team1
    ))
  } else {
    cat(sprintf(
      paste0(
        "\nYear: %s\n%s vs %s\n\n%s Wins: %d (%.1f%%)\n",
        "%s Wins: %d (%.1f%%)\n\nWinner: %s\n"
      ),
      input_year, team1, team2,
      team2, t2_wins, t2_pct,
      team1, t1_wins, t1_pct,
      team2
    ))
  }
}
