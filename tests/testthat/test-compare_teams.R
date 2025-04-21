test_that("compare_teams returns expected structure and values", {
  # Sample mock data to use in the test
  mock_data <- data.frame(
    year = c(2020, 2020, 2020, 2021),
    team = c("Team A", "Team B", "Team C", "Team A"),
    ftr = c(0.25, 0.30, 0.22, 0.28),
    two_pt_pct = c(0.52, 0.48, 0.50, 0.51),
    three_pt_pct = c(0.38, 0.35, 0.40, 0.36),
    def_ftr.y = c(0.20, 0.22, 0.21, 0.23),
    def_two_pt_pct = c(0.45, 0.47, 0.44, 0.46),
    def_three_pt_pct = c(0.32, 0.34, 0.33, 0.31),
    stringsAsFactors = FALSE
  )

  result <- compare_teams(2020, "Team A", "Team B", data = mock_data)

  # Check return type and dimensions
  expect_s3_class(result, "data.frame")
  expect_equal(nrow(result), 2)
  expect_named(result, c("team", "ftr", "two_pt_pct", "three_pt_pct",
                         "def_ftr.y", "def_two_pt_pct", "def_three_pt_pct"))

  # Check that the order of teams is respected
  expect_equal(result$team[1], "Team A")
  expect_equal(result$team[2], "Team B")
})

test_that("compare_teams throws error for invalid input", {
  mock_data <- data.frame(
    year = 2020,
    team = "Team A",
    ftr = 0.25,
    two_pt_pct = 0.52,
    three_pt_pct = 0.38,
    def_ftr.y = 0.20,
    def_two_pt_pct = 0.45,
    def_three_pt_pct = 0.32,
    stringsAsFactors = FALSE
  )

  # Invalid year
  expect_error(compare_teams(1999, "Team A", "Team A", data = mock_data))

  # Team not in data
  expect_error(compare_teams(2020, "Team A", "Nonexistent", data = mock_data))
})

test_that("plot_compare_teams returns a ggplot object", {
  skip_if_not_installed("ggplot2")
  skip_if_not_installed("reshape2")

  # Minimal valid comparison_df
  comparison_df <- data.frame(
    team = c("Team A", "Team B"),
    ftr = c(0.25, 0.30),
    two_pt_pct = c(0.52, 0.48),
    three_pt_pct = c(0.38, 0.35),
    def_ftr.y = c(0.20, 0.22),
    def_two_pt_pct = c(0.45, 0.47),
    def_three_pt_pct = c(0.32, 0.34),
    stringsAsFactors = FALSE
  )

  p <- plot_compare_teams(comparison_df)

  expect_s3_class(p, "ggplot")
})

test_that("plot_compare_teams throws error for invalid input", {
  # Not a data frame
  expect_error(plot_compare_teams("not a df"))

  # Not two rows
  one_row_df <- data.frame(
    team = "Team A",
    ftr = 0.25,
    two_pt_pct = 0.52,
    three_pt_pct = 0.38,
    def_ftr.y = 0.20,
    def_two_pt_pct = 0.45,
    def_three_pt_pct = 0.32,
    stringsAsFactors = FALSE
  )

  expect_error(plot_compare_teams(one_row_df))
})

# Optional: Visual test (if using vdiffr for snapshot testing)
test_that("plot_compare_teams plot matches expected output", {
  skip_if_not_installed("vdiffr")

  comparison_df <- data.frame(
    team = c("Team A", "Team B"),
    ftr = c(0.25, 0.30),
    two_pt_pct = c(0.52, 0.48),
    three_pt_pct = c(0.38, 0.35),
    def_ftr.y = c(0.20, 0.22),
    def_two_pt_pct = c(0.45, 0.47),
    def_three_pt_pct = c(0.32, 0.34),
    stringsAsFactors = FALSE
  )

  p <- plot_compare_teams(comparison_df)

  vdiffr::expect_doppelganger("Basic team comparison plot", p)
})
