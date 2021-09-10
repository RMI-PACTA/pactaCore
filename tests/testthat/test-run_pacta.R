test_that("doesn't fail if output exists but is empty", {
  skip_on_ci()
  skip_on_cran()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  dir_create(results_path(parent))

  expect_no_error(run_pacta_impl(path(parent, ".env"), code = NULL))
})

test_that("avoids overwritting output from a prevoius run", {
  skip_on_ci()
  skip_on_cran()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  fs::dir_create(path(results_path(parent)))
  fs::file_create(path(results_path(parent), "some.file"))
  expect_error(run_pacta_impl(path(parent, ".env"), NULL), "must be empty")
})

test_that("without portfolio errors gracefully", {
  skip_on_ci()
  skip_on_cran()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  fs::file_delete(path(parent, "input", "TestPortfolio_Input.csv"))
  expect_snapshot_error(run_pacta_impl(path(parent, ".env"), code = NULL))
})

test_that("without a parameter file errors gracefully", {
  skip_on_ci()
  skip_on_cran()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  param <- path(parent, "input", "TestPortfolio_Input_PortfolioParameters.yml")
  fs::file_delete(param)
  expect_snapshot_error(run_pacta_impl(path(parent, ".env"), code = NULL))
})
