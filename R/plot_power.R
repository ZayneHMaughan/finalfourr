#' See teams power rating over the years
#'
#' Input a team and you will see how their power ranking changed over the years
#'
#' @param team team name
#'
#' @name plot_power
#'
#' @examples
#' plot_power("Utah St.")
#'
#' @export
utils::globalVariables("barthag")
plot_power <- function(team) {
  filtered <- filter_team(team) |>
    dplyr::select(team, year, barthag)

  graphics::plot(filtered$year, filtered$barthag,
    pch = 19, xlab = "Season",
    ylab = "Power Ranking", main = team, col = "firebrick"
  )
  graphics::lines(filtered$year, filtered$barthag, lwd = 2, col = "#00274C")
  graphics::axis(1, at = c(2013, 2015, 2017, 2019, 2021, 2023))
}
