test_that("search_team returns correct teams", {
  expected_1 <- dplyr::tibble(team = c(
    "Southern Utah",
    "Utah",
    "Utah St.",
    "Utah Tech",
    "Utah Valley"
  )) %>%
    dplyr::group_by(team)

  result_1 <- search_team("Utah", include_years = FALSE)

  expect_equal(result_1, expected_1)

  expected_2 <- dplyr::tibble(
    team = "Utah St.",
    years = paste0("2013, 2014, 2015, 2016, 2017, 2018, ",
                   "2019, 2020, 2021, 2022, 2023, 2024")
  )

  result_2 <- search_team("Utah St.")

  expect_equal(result_2, expected_2)
})

test_that("search_team errors for invalid keyword input", {
  expect_error(search_team(NULL),
               "`keyword` must be a non-empty character string.")
  expect_error(search_team(123),
               "`keyword` must be a non-empty character string.")
  expect_error(search_team(c("Utah", "Texas")),
               "`keyword` must be a non-empty character string.")
  expect_error(search_team(""),
               "`keyword` must be a non-empty character string.")
})

test_that("search_team errors for invalid include_years input", {
  expect_error(search_team("Utah", include_years = "yes"),
               "`include_years` must be a single logical value")
  expect_error(search_team("Utah", include_years = c(TRUE, FALSE)),
               "`include_years` must be a single logical value")
})

test_that("search_team handles no matches", {
  expect_null(suppressMessages(search_team("Utah5")))
  expect_null(suppressMessages(search_team("computer")))
})
