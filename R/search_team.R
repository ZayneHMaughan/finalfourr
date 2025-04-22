utils::globalVariables(c("team", "year"))
#' Search for Teams by Keyword
#'
#' Searches the `cbb_data` for team names containing a given keyword.
#' Optionally includes a list of years associated with each matching team.
#'
#' @param keyword A character string used to search within team names.
#' Case-insensitive.
#' @param include_years Logical; if `TRUE` (default), returns matching teams
#' along with the years they appear in. If `FALSE`, returns only
#' distinct team names.
#'
#' @return A tibble showing teams (and optionally the years)
#' that match the keyword.
#'
#' @examples
#' # Find all teams containing "Utah"
#' search_team("Utah")
#'
#' # Find all teams with "East" in the name, without showing years
#' search_team("East", include_years = FALSE)
#'
#' @export
search_team <- function(keyword, include_years = TRUE) {
  # Check if keyword is a non-empty string
  if (!is.character(keyword) || length(keyword) != 1 || nchar(keyword) == 0) {
    stop("`keyword` must be a non-empty character string.")
  }

  # Check if include_years is a logical value
  if (!is.logical(include_years) || length(include_years) != 1) {
    stop("`include_years` must be a single logical value (TRUE or FALSE).")
  }

  result <- cbb_data |>
    dplyr::filter(grepl(keyword, team, ignore.case = TRUE)) |>
    dplyr::distinct(team, year)

  # Handle case when no matches are found
  if (nrow(result) == 0) {
    message("No matching teams found for keyword: ", keyword)
    message("Please try again")
    return(invisible(NULL))
  }

  if (include_years) {
    result <- result |>
      dplyr::group_by(team) |>
      dplyr::summarise(years = paste(sort(unique(year)),
        collapse = ", "
      )) |>
      dplyr::arrange(team)
  } else {
    result <- result |>
      dplyr::distinct(team) |>
      dplyr::arrange(team)
  }

  result
}
