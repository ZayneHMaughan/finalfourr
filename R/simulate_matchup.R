utils::globalVariables(c("team", "year", "adj_o.x", "adj_d.x",
                         "adj_t", "pts", "efg", "tov_rate", "cbb_data"))
#' Simulate a Matchup Between Two Teams
#'
#' Simulates `n_sim` games between two NCAA basketball teams for a given year
#' using adjusted offensive and defensive metrics from KenPom-style data. This
#' function estimates each team's scoring potential and variability, runs a
#' Monte Carlo simulation of multiple games, and returns estimated win
#' probabilities along with a predicted winner.
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
#' For each simulated game, the model:
#' \enumerate{
#'   \item Estimates the expected number of possessions by averaging
#'   both teams' tempo.
#'   \item Calculates each team’s expected score using their offensive
#'   efficiency and the opponent’s defensive efficiency.
#'   \item Uses a custom standard deviation function (\code{calc_sd()})
#'   to introduce score variability based on a team's efficiency
#'   and turnover rate.
#'   \item Draws scores for each team from a normal distribution based
#'   on the calculated mean (expected score) and
#'   standard deviation (team's efficiency).
#'   \item Compares scores to determine the winner of each simulation.
#' }
#'
#' This model is **stochastic**, not deterministic. Because scores are drawn
#' from a random distribution, the simulation includes variability and
#' uncertainty — the same input may yield slightly different win
#' probabilities each time it's run.
#'
#' The final prediction is based on which team wins the majority
#' of the simulated games.
#' The function also relies on `validate_compare_inputs()`to ensure teams and
#' year are valid before simulating.
#'
#' @examples
#' set.seed(387)
#' # Simulate 1000 games between Utah and Baylor in 2015
#' simulate_matchup("Utah", "Baylor", 2015)
#'
#' # Simulate only 500 games
#' simulate_matchup("Utah", "BYU", 2013, n_sim = 500)
#'
#' @export
utils::globalVariables(c("pts", "efg", "tov_rate"))

simulate_matchup <- function(team1, team2, input_year,
                             n_sim = 1000) {
  # validate inputs
  validate_compare_inputs(input_year, team1, team2, data = cbb_data)
  # Filter data
  teams_data <- cbb_data |>
    dplyr::filter(team %in% c(team1, team2), year == input_year) |>
    dplyr::select(team, adj_o.x, adj_d.x, adj_t, pts, efg, tov_rate)

  # Split teams
  t1 <- teams_data |>
    dplyr::filter(team == team1)
  t2 <- teams_data |>
    dplyr::filter(team == team2)

  t1_wins <- 0
  t2_wins <- 0

  # Average of both teams’ tempo
  possessions <- (t1$adj_t + t2$adj_t) / 2

  #Calculate the teams expected points
  team1_mean <- (t1$adj_o.x * t2$adj_d.x) / 100 * possessions / 100
  team2_mean <- (t2$adj_o.x * t1$adj_d.x) / 100 * possessions / 100

  #Calculate SD for each team
  team1_sd <- calc_sd(t1$pts, t1$efg, t1$tov_rate)
  team2_sd <- calc_sd(t2$pts, t2$efg, t2$tov_rate)

  # Simulation loop
  for (i in 1:n_sim) {

    # Simulate each team's score by drawing from a normal distribution:
    # - Mean is based on their offensive efficiency adjusted for
    # opponent's defense and tempo (expected score)
    # - SD reflects game-to-game scoring variability
    # (based on efficiency and turnovers)
    t1_score <- stats::rnorm(1, mean = team1_mean, sd = team1_sd)
    t2_score <- stats::rnorm(1, mean = team2_mean, sd = team2_sd)

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


#' Calculate Standard Deviation for Simulated team
#'
#' Estimates the standard deviation of a team's score in a simulated game
#' based on its expected points, offensive efficiency (eFG%), and turnover rate.
#' The function is designed to reflect inconsistency from inefficient offenses
#' or turnover-prone teams.
#'
#' @param pts Numeric. Expected number of points scored in the game.
#' @param efg Numeric. Effective field goal percentage (between 0 and 1).
#' @param tov_rate Numeric. Turnover rate (between 0 and 1).
#'
#' @return A numeric value representing the clamped standard deviation
#' of the team's score. The value is bounded between 3 and 15.
#'
#' @details
#' The standard deviation is calculated as 5% of expected points (`pts`) plus
#' a penalty for poor shooting and ball control:
#' \itemize{
#'   \item \code{(1 - efg) * 10} reflects the inefficiency of shooting
#'   \item \code{tov_rate * 8} reflects the cost of turnovers
#' }
#' The total standard deviation is then clamped to a minimum of 3 and
#' a maximum of 15 to prevent unrealistic variance.
#'
calc_sd <- function(pts, efg, tov_rate) {
  # Base on points per game (5% of PPG)
  base_sd <- pts * 0.05
  # Penalty term (effective field goal percentage & turnover rates)
  # Sloppy or inefficient offenses have higher SD
  inconsistency_penalty <- (1 - efg) * 10 + tov_rate * 8
  final_sd <- base_sd + inconsistency_penalty
  # Clamp between 3 and 15 to avoid extreme values
  max(3, min(final_sd, 15))
}
