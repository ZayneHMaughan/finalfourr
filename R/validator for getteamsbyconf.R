#' Validate Inputs for get_teams_by_conf
#'
#' @param data The dataset to check.
#' @param year The year to validate.
#'
#' @return Stops with an error message if input is invalid;
#'             otherwise, returns TRUE invisibly.
validate_inputs <- function(data, year) {
  if (!is.data.frame(data)) {
    stop("The 'data' argument must be a data frame.")
  }
  required_cols <- c("year", "team", "CONF")
  missing_cols <- setdiff(required_cols, colnames(data))
  if (length(missing_cols) > 0) {
    stop(paste("Missing required columns:", paste(missing_cols,
                                                  collapse = ", ")))
  }
  if (!is.numeric(year) || length(year) != 1 || year %% 1 != 0) {
    stop("The 'year' must be a single integer.")
  }
  if (!year %in% data$year) {
    stop("The specified year is not in the dataset.")
  }
  invisible(TRUE)
}
