#' Get NCAA Tournament Teams for a Given Year
#'
#' Returns all teams that participated in the NCAA tournament for a given year.
#' This function is forward-compatible by assuming that any POSTSEASON label
#' other than "0", "N/A", or NA indicates a bracket team.
#'
#' @param yr An integer year to query.
#' @param data A data frame containing the dataset. Defaults to \code{cbb_data}.
#'
#' @return A sorted character vector of team names that made the NCAA bracket
#'     in the given year.
#'
#' @name get_bracket_teams
#' @export
#'
#' @examples
#' get_bracket_teams(2023)
utils::globalVariables(c("year", "POSTSEASON"))
get_bracket_teams <- function(yr, data = cbb_data) {
  validate_bracket_inputs(yr, data)

  # Keep only teams with a valid bracket POSTSEASON label
  filtered <- subset(
    data,
    year == yr &
      !is.na(POSTSEASON) &
      !(POSTSEASON %in% c("0", "N/A"))
  )

  sort(unique(filtered$team))
}
