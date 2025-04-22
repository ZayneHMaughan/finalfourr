test_that("Get teams record works", {
  expect_equal(dim(get_team_record("Utah St.")), c(12, 4))
})
