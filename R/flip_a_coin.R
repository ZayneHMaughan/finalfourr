#' Stochastically Determine a Binary Outcome Between Two Teams (coin flip)
#'
#' Executes a rudimentary probabilistic mechanism—colloquially referred to as
#' a "coin flip"—to arbitrarily designate a victor
#' between two user-specified competitive teams.
#'
#' @param team1 A character string representing the identifier
#' of the first team.
#'
#' @param team2 A character string corresponding to the second
#' team’s identifier.
#'
#' @return This function does not return a structured object.
#' Instead, it executes a pseudo-random selection algorithm to determine a
#' "winner" from the two supplied teams, and subsequently emits a declarative
#' textual message to the console announcing the outcome.
#'
#' @details
#' This method is devoid of any analytical rigor or data-driven inference;
#' it is purely stochastic and serves primarily as a whimsical or
#' demonstrative exercise rather than a substantive evaluative tool.
#'
#' @examples
#' set.seed(348)
#' # Flip a coin between two teams
#' flip_a_coin("BYU", "Utah")
#'
#' @export
flip_a_coin <- function(team1, team2) {
  if (!any(cbb_data$team == team1)) {
    stop(paste0("Cannot find team1 ('", team1, "') in the dataset."))
  }
  if (!any(cbb_data$team == team2)) {
    stop(paste0("Cannot find team2 ('", team2, "') in the dataset."))
  }
  winner <- sample(c(team1, team2), 1)
  for (i in 1:20) {
    Sys.sleep(0.1)
    total <- 20
    bar_length <- 20
    done <- round((i / total) * bar_length)
    bar <- paste0(
      paste(rep("=", done), collapse = ""),
      paste(rep("-", bar_length - done), collapse = "")
    )
    cat(sprintf("\r[%s] %3d%%", bar, round(i / total * 100)))
  }
  cat(paste0("\n", "The Winner is ", winner))
}
