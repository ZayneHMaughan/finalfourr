#' Extract a teams wins and losses in a given season
#'
#' Input a team name and range of years to get their totals wins and loses by
#'    season
#'
#' @param team_name String. The school's name
#' @param season_range Integer vector. A range of years (e.g., 2013:2024)
#'
#' @name get_team_record
#'
#' @examples
#' get_team_record("Utah St.", 2014:2020)
#'
#' @export

utils::globalVariables(c("team", "year", "wins", "losses"))
get_team_record <- function(team_name, season_range = NULL) {
  record <- data.frame()
  if (is.null(season_range)) {
    for (year in 2013:2024) {
      year_data <- filter_team(team_name, year)
      record <- rbind(record, year_data)
    }
  }
  for (year in season_range) {
    year_data <- filter_team(team_name, year)
    record <- rbind(record, year_data)
  }
  record <- record |>
    dplyr::select(team, year, wins, losses)

  record
}
