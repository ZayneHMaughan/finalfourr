#' Validate Inputs for compare_teams
#'
#' @param year Year to validate (must exist in the dataset).
#' @param team1 First team to compare.
#' @param team2 Second team to compare.
#' @param data The dataset to validate.
#'
#' @return Stops with an error message if validation fails.
validate_compare_inputs <- function(year, team1, team2, data) {
  if (!is.data.frame(data)) stop("Data must be a data frame.")
  required_cols <- c("year", "team", "ftr", "two_pt_pct", "three_pt_pct",
                     "def_ftr.y", "def_two_pt_pct", "def_three_pt_pct")
  missing_cols <- setdiff(required_cols, names(data))
  if (length(missing_cols) > 0) {
    stop("Missing required columns: ", paste(missing_cols, collapse = ", "))
  }
  if (!is.numeric(year) || length(year) != 1 || year %% 1 != 0) {
    stop("Year must be a single integer.")
  }
  if (!(year %in% data$year)) {
    stop("Year not found in dataset.")
  }
  teams_in_year <- data$team[data$year == year]
  if (!(team1 %in% teams_in_year)) {
    stop(paste("Team 1 (", team1, ") not found in year ", year, ".", sep = ""))
  }
  if (!(team2 %in% teams_in_year)) {
    stop(paste("Team 2 (", team2, ") not found in year ", year, ".", sep = ""))
  }
}
