test_that("outputs datasets with the expected structure", {
  skip_on_ci()
  skip_on_cran()
  skip_if(skip_slow_test())

  pacta <- local_pacta()
  env <- path(pacta, ".env")
  run_pacta(env)

  results <- path_dir(output_results_path(pacta))
  reference <- private_path("pacta_core")
  dir_duplicate(results, reference)

  datasets <- enlist_rds(results)
  dimensions <- lapply(datasets, dim)
  expect_snapshot(dimensions)
  classes <- classes(datasets)
  expect_snapshot(classes)
})

test_that("avoids overwritting output from a prevoius run", {
  skip_on_ci()
  skip_on_cran()
  pacta <- path_home("pacta_tmp")
  local_pacta(pacta)

  dir_create(path(output_results_path(pacta)))
  file_create(path(output_results_path(pacta), "some.file"))
  expect_error(run_pacta(path(pacta, ".env")), "must be empty")
})

test_that("without portfolio errors gracefully", {
  skip_on_ci()
  skip_on_cran()
  pacta <- path_home("pacta_tmp")
  local_pacta(pacta)

  file_delete(path(pacta, "input", "TestPortfolio_Input.csv"))
  expect_snapshot_error(run_pacta(path(pacta, ".env")))
})

test_that("without a parameter file errors gracefully", {
  skip_on_ci()
  skip_on_cran()
  pacta <- path_home("pacta_tmp")
  local_pacta(pacta)

  param <- path(pacta, "input", "TestPortfolio_Input_PortfolioParameters.yml")
  file_delete(param)
  expect_snapshot_error(run_pacta(path(pacta, ".env")))
})

test_that("without an .env file errors gracefully", {
  local_dir(tempdir())
  expect_error(run_pacta_impl(code = NULL), "env.*doesn't exist")
})

test_that("if there is no input/ directory errors gracefully", {
  pacta <- local_pacta()
  env <- path(pacta, ".env")
  input <- path_env("PACTA_INPUT", env = env)
  dir_delete(input)

  expect_error(run_pacta_impl(env, code = NULL), "directory must exist")
})

test_that("without PACTA_INPUT errors gracefully", {
  pacta <- local_pacta()
  env <- path(pacta, ".env")
  writeLines(gsub("^PACTA_INPUT.*", "", readLines(env)), env)

  expect_error(run_pacta_impl(env, code = NULL), "PACTA_INPUT must be set")
})

test_that("without PACTA_OUTPUT errors gracefully", {
  pacta <- local_pacta()
  env <- path(pacta, ".env")
  writeLines(gsub("^PACTA_OUTPUT*", "", readLines(env)), env)

  expect_error(run_pacta_impl(env, code = NULL), "PACTA_INPUT must be set")
})

test_that("without PACTA_DATA errors gracefully", {
  pacta <- local_pacta()
  env <- path(pacta, ".env")
  writeLines(gsub("^PACTA_DATA*", "", readLines(env)), env)

  expect_error(run_pacta_impl(env, code = NULL), "PACTA_INPUT must be set")
})

