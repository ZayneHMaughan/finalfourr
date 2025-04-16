#' Extract a teams wins and losses in a given season
#'
#'
#'
#' @param team_name String. The school's name
#' @param season_range Integer vector. A range of years (e.g., 2013:2024)
#'
#' @export

get_team_record <- function(team_name, season_range = NULL){
  record <- data.frame()
  if(is.null(season_range)){
    for (year in 2013:2024){
      year_data <- filter_team(team_name, year)
      record <- rbind(record, year_data)
    }
  }
  for(year in season_range){
    year_data <- filter_team(team_name, year)
    record <- rbind(record, year_data)
  }
  record|>
    dplyr :: select(team,year, wins, losses) -> record

  record
}
