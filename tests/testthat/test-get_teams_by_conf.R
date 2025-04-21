test_that("get_teams_by_conf returns correct structure and values", {
  mock_data <- data.frame(
    year = c(2020, 2020, 2020, 2020, 2021),
    team = c("Team A", "Team B", "Team C", "Team D", "Team A"),
    CONF = c("Big East", "Big East", "SEC", "SEC", "Big East"),
    stringsAsFactors = FALSE
  )

  result <- get_teams_by_conf(2020, data = mock_data)

  expect_type(result, "list")
  expect_named(result, c("Big East", "SEC"))
  expect_equal(result$`Big East`, c("Team A", "Team B"))
  expect_equal(result$SEC, c("Team C", "Team D"))
})

test_that("get_teams_by_conf throws error when year not in dataset", {
  mock_data <- data.frame(
    year = c(2019, 2020),
    team = c("Team A", "Team B"),
    CONF = c("Pac-12", "ACC"),
    stringsAsFactors = FALSE
  )

  expect_error(get_teams_by_conf(2022, data = mock_data),
               "The specified year is not in the dataset")
})

test_that("get_teams_by_conf throws error if required columns are missing", {
  mock_data_missing <- data.frame(
    year = c(2020, 2020),
    team = c("Team A", "Team B"),
    stringsAsFactors = FALSE
  )

  expect_error(get_teams_by_conf(2020, data = mock_data_missing))
})
