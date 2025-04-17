# A helper function to pull all of the stats for any specific team

filter_team <- function(team_name, season = NULL) {
  filtered <- DATASET |>
    dplyr::filter(.data$team == team_name)

  if (!is.null(season)) {
    filtered <- filtered |> dplyr::filter(.data$year == season)
  }

  filtered
}

