library(dplyr)
## code to prepare `DATASET` dataset goes here
kaggle <- read.csv("data-raw/cbb.csv")


# Change 'Dixie St.' to 'Utah Tech' in the 'TEAM' column
kaggle <- kaggle |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Dixie St.', 'Utah Tech', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'North Carolina St.', 'N.C. State', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Detroit', 'Detroit Mercy', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Fort Wayne', 'Purdue Fort Wayne', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'IPFW', 'Purdue Fort Wayne', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Dixie St.', 'Utah Tech', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Houston Baptist', 'Houston Christian', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'IUPUI', 'IU Indy', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'LIU Brooklyn', 'LIU', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Louisiana Lafayette', 'Louisiana', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'St. Francis PA', 'Saint Francis', TEAM))  |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'College of Charleston', 'Charleston', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Arkansas Little Rock', 'Little Rock', TEAM))|>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'N.C. St.', 'N.C. State', TEAM))

sapply(kaggle, function(x) sum(is.na(x)))


cbb <- data.frame()

for(year in 2013:2024){
  year_data <- cbbdata::cbd_torvik_team_factors(year = year)

  cbb <- rbind(cbb, year_data)
}

cbbdata::cbd_torvik_ratings(year = 2008)
cbbdata::cbd_torvik_team_split(split = 'game_type') -> season_stats

season_stats |>
  filter(type != "post") |>
  filter(year %in% c(2013:2024)) |>
  group_by(team, year) |>
  summarize(across(where(is.numeric), mean )) -> season_stats


season_stats |>
  dplyr :: mutate(team = ifelse(team == 'Dixie St.', 'Utah Tech', team)) |>
  dplyr :: mutate(team = ifelse(team == 'North Carolina St.', 'N.C. State', team)) |>
  dplyr :: mutate(team = ifelse(team == 'Detroit', 'Detroit Mercy', team)) |>
  dplyr :: mutate(team = ifelse(team == 'Fort Wayne', 'Purdue Fort Wayne', team)) |>
  dplyr :: mutate(team = ifelse(team == 'IPFW', 'Purdue Fort Wayne', team)) |>
  dplyr :: mutate(team = ifelse(team == 'Dixie St.', 'Utah Tech', team)) |>
  dplyr :: mutate(team = ifelse(team == 'Houston Baptist', 'Houston Christian', team)) |>
  dplyr :: mutate(team = ifelse(team == 'IUPUI', 'IU Indy', team)) |>
  dplyr :: mutate(team = ifelse(team == 'LIU Brooklyn', 'LIU', team)) |>
  dplyr :: mutate(team = ifelse(team == 'Louisiana Lafayette', 'Louisiana', team)) |>
  dplyr :: mutate(team = ifelse(team == 'St. Francis PA', 'Saint Francis', team))  |>
  dplyr :: mutate(team = ifelse(team == 'College of Charleston', 'Charleston', team)) |>
  dplyr :: mutate(team = ifelse(team == 'Arkansas Little Rock', 'Little Rock', team))|>
  dplyr :: mutate(team = ifelse(team == 'N.C. St.', 'N.C. State', team))-> season_stats

season_stats |>
  left_join(cbb, by = c("team", "year")) |>
  dplyr::select(!c(def_ft_pct, avg_marg, conf, ft_pct.x)) |>
  left_join(kaggle, by = c("team" = "TEAM", "year" = "YEAR" ) )|>
  tidyr::replace_na(list(0)) |>
  mutate(
    POSTSEASON = ifelse(is.na(POSTSEASON),"0" ,POSTSEASON),
    SEED = ifelse(is.na(SEED), "100", SEED)
  ) |>
  dplyr::select( !c(G, W, "ADJDE", "BARTHAG", "EFG_O",
             "EFG_D", "TOR", "TORD", "ORB","DRB",
       "FTR", "FTRD","X2P_O" ,"X2P_D", "X3P_O", "X3P_D", "ADJ_T", "WAB" )
  ) -> DATASET




sapply(big_data, function(x) sum(is.na(x)))
#combined_df <- rbind(cbb, kaggle)

usethis::use_data(DATASET, overwrite = TRUE)
