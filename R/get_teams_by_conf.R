#' Get Teams by Conference for a Given Year
#'
#' This function returns a list of conferences and the teams that were in each conference for a specified year.
#'
#' @param year An integer year for which the user wants to retrieve conference-team mappings.
#' @param data A data frame containing the dataset (must include 'year', 'team', and 'CONF' columns).
#'             Defaults to \code{DATSET}, which must exist in the global environment.
#'
#' @return A named list where each element corresponds to a conference and contains the vector of teams in that conference for the given year.
#' @export
#'
#' @examples
#' get_teams_by_conf(2018)
get_teams_by_conf <- function(year, data = DATASET) {
  validate_inputs(data, year)

  # Proper subsetting using data$year
  year_data <- data[data$year == year, ]

  # Return teams split by CONF
  split(year_data$team, year_data$CONF)
}
