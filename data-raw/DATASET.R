## code to prepare `DATASET` dataset goes here
kaggle <- read.csv("data-raw/cbb.csv")


# Change 'Dixie St.' to 'Utah Tech' in the 'TEAM' column
kaggle <- kaggle |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Dixie St.', 'Utah Tech', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'North Carolina St.', 'N.C. St.', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Detroit', 'Detroit Mercy', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Fort Wayne', 'Purdue Fort Wayne', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'IPFW', 'Purdue Fort Wayne', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Dixie St.', 'Utah Tech', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Huston Baptist', 'Huston Christian', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'IUPUI', 'IU Indy', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'LIU Brooklyn', 'LIU', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'Louisiana Lafayette', 'Louisiana', TEAM)) |>
  dplyr :: mutate(TEAM = ifelse(TEAM == 'St. Francis PA', 'Saint Francis', TEAM))


cbb <- data.frame()

for(year in 2013:2024){
  year_data <- cbbdata::cbd_torvik_team_factors(year = year)

  cbb <- rbind(cbb, year_data)
}

#combined_df <- rbind(cbb, kaggle)

usethis::use_data(DATASET, overwrite = TRUE)
