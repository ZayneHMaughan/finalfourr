## code to prepare `cbb_data` dataset goes here

# Read in the csv which can be found on kaggle
kaggle <- read.csv("data-raw/cbb.csv")

# Update the names of the teams to match the cbb data below
kaggle <- kaggle |>
  dplyr::mutate(TEAM = ifelse(TEAM == "Dixie St.", "Utah Tech", TEAM)) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "North Carolina St.", "N.C. State",
    TEAM
  )) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "Detroit", "Detroit Mercy", TEAM)) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "Fort Wayne", "Purdue Fort Wayne",
    TEAM
  )) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "IPFW", "Purdue Fort Wayne", TEAM)) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "Dixie St.", "Utah Tech", TEAM)) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "Houston Baptist", "Houston Christian",
    TEAM
  )) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "IUPUI", "IU Indy", TEAM)) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "LIU Brooklyn", "LIU", TEAM)) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "Louisiana Lafayette", "Louisiana",
    TEAM
  )) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "St. Francis PA", "Saint Francis",
    TEAM
  )) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "College of Charleston", "Charleston",
    TEAM
  )) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "Arkansas Little Rock", "Little Rock",
    TEAM
  )) |>
  dplyr::mutate(TEAM = ifelse(TEAM == "N.C. St.", "N.C. State", TEAM))

# Create an empty dataframe to store the data being read in
cbb <- data.frame()

# Read the data in from the cbbdata package
# Note you need to create and register an API key which is explained on the site
cbbdata::cbd_login()
for (year in 2013:2024) {
  year_data <- cbbdata::cbd_torvik_team_factors(year = year)

  cbb <- rbind(cbb, year_data)
}

# Store the season stats from cbd_torvik_team_split
season_stats <- cbbdata::cbd_torvik_team_split(split = "game_type")

# Filter the information to match the years and teams from the kaggle dataset
season_stats <- season_stats |>
  dplyr::filter(type != "post") |>
  dplyr::filter(year %in% c(2013:2024)) |>
  dplyr::group_by(team, year) |>
  dplyr::summarize(across(where(is.numeric), mean))

# Update team names to be consistent across datasets
season_stats <- season_stats |>
  dplyr::mutate(team = ifelse(team == "Dixie St.", "Utah Tech", team)) |>
  dplyr::mutate(team = ifelse(team == "North Carolina St.", "N.C. State",
    team
  )) |>
  dplyr::mutate(team = ifelse(team == "Detroit", "Detroit Mercy", team)) |>
  dplyr::mutate(team = ifelse(team == "Fort Wayne", "Purdue Fort Wayne",
    team
  )) |>
  dplyr::mutate(team = ifelse(team == "IPFW", "Purdue Fort Wayne", team)) |>
  dplyr::mutate(team = ifelse(team == "Dixie St.", "Utah Tech", team)) |>
  dplyr::mutate(team = ifelse(team == "Houston Baptist", "Houston Christian",
    team
  )) |>
  dplyr::mutate(team = ifelse(team == "IUPUI", "IU Indy", team)) |>
  dplyr::mutate(team = ifelse(team == "LIU Brooklyn", "LIU", team)) |>
  dplyr::mutate(team = ifelse(team == "Louisiana Lafayette", "Louisiana",
    team
  )) |>
  dplyr::mutate(team = ifelse(team == "St. Francis PA", "Saint Francis",
    team
  )) |>
  dplyr::mutate(team = ifelse(team == "College of Charleston", "Charleston",
    team
  )) |>
  dplyr::mutate(team = ifelse(team == "Arkansas Little Rock", "Little Rock",
    team
  )) |>
  dplyr::mutate(team = ifelse(team == "N.C. St.", "N.C. State", team))

# Join the datasets together on the teams and the years
cbb_data <- season_stats |>
  dplyr::left_join(cbb, by = c("team", "year")) |>
  dplyr::select(!c(def_ft_pct, avg_marg, conf, ft_pct.x)) |>
  dplyr::left_join(kaggle, by = c("team" = "TEAM", "year" = "YEAR")) |>
  tidyr::replace_na(list(0)) |>
  dplyr::mutate(
    POSTSEASON = ifelse((is.na(POSTSEASON) | POSTSEASON == "N/A"),
      "0", POSTSEASON
    ),
    SEED = ifelse((is.na(SEED) | SEED == "N/A"), "100", SEED)
  ) |>
  dplyr::select(!c(
    G, W, "ADJDE", "BARTHAG", "EFG_O",
    "EFG_D", "TOR", "TORD", "ORB", "DRB",
    "FTR", "FTRD", "X2P_O", "X2P_D", "X3P_O", "X3P_D", "ADJ_T", "WAB", "ADJOE",
    block_rate, block_rate_allowed
  ))



usethis::use_data(cbb_data, overwrite = TRUE)
