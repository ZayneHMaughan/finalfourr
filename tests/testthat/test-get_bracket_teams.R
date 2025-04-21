test_that("get_bracket_teams returns correct bracket teams", {
  mock_data <- data.frame(
    year = c(2023, 2023, 2023, 2023, 2022),
    team = c("Auburn", "BYU", "Clemson", "Duke", "Duke"),
    POSTSEASON = c("R64", "N/A", "E8", "0", "S16"),
    stringsAsFactors = FALSE
  )

  result <- get_bracket_teams(2023, data = mock_data)

  # Should only include Auburn and Clemson
  expect_type(result, "character")
  expect_length(result, 2)
  expect_equal(result, sort(c("Auburn", "Clemson")))
})

test_that("get_bracket_teams returns empty vector when no valid teams exist", {
  mock_data <- data.frame(
    year = 2023,
    team = c("Team A", "Team B"),
    POSTSEASON = c("0", "N/A"),
    stringsAsFactors = FALSE
  )

  result <- get_bracket_teams(2023, data = mock_data)

  expect_type(result, "character")
  expect_length(result, 0)
})

test_that("get_bracket_teams throws error for invalid year", {
  mock_data <- data.frame(
    year = 2022,
    team = c("Team A", "Team B"),
    POSTSEASON = c("R64", "S16"),
    stringsAsFactors = FALSE
  )

  expect_error(get_bracket_teams(1999, data = mock_data))
})
