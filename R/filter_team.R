#' Pull all of the stats for any specific team
#'
#' Get all of the information in the dataset for any team in any season
#'
#' @param team_name Team name
#' @param season the year you want the information default is all seasons
#'
#' @name filter_team
#'
#' @examples
#' filter_team("Utah St.")
#' filter_team("N.C. State", 2016)
#'
#' @export

utils::globalVariables(c("team", "year"))
filter_team <- function(team_name, season = NULL) {
  filtered <- DATASET |>
    dplyr::filter(team == team_name)

  if (!is.null(season)) {
    filtered <- filtered |> dplyr::filter(year == season)
  }

  filtered
}
