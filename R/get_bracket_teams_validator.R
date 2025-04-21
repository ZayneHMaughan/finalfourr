#' Validate Inputs for get_bracket_teams
#'
#' @param yr The year to check.
#' @param data The dataset to check.
#'
#' @return Stops with an error if invalid input is detected.
validate_bracket_inputs <- function(yr, data) {
  if (!is.data.frame(data)) stop("Data must be a data frame.")
  if (!all(c("year", "team", "POSTSEASON") %in% names(data))) {
    stop("Data must contain 'year', 'team', and 'POSTSEASON' columns.")
  }
  if (!is.numeric(yr) || length(yr) != 1 || yr %% 1 != 0) {
    stop("Year must be a single integer.")
  }
  if (!yr %in% data$year) {
    stop("The specified year is not present in the dataset.")
  }
}
