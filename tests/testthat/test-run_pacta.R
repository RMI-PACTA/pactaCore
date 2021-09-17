test_that("outputs datasets with the expected structure", {
  skip_on_ci()
  skip_on_cran()
  skip_slow_tests()

  read_env()
  pacta <- "~/pacta_tmp"
  local_pacta(pacta)
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
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  dir_create(path(output_results_path(parent)))
  file_create(path(output_results_path(parent), "some.file"))
  expect_error(run_pacta(path(parent, ".env")), "must be empty")
})

test_that("without portfolio errors gracefully", {
  skip_on_ci()
  skip_on_cran()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  file_delete(path(parent, "input", "TestPortfolio_Input.csv"))
  expect_snapshot_error(run_pacta(path(parent, ".env")))
})

test_that("without a parameter file errors gracefully", {
  skip_on_ci()
  skip_on_cran()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  param <- path(parent, "input", "TestPortfolio_Input_PortfolioParameters.yml")
  file_delete(param)
  expect_snapshot_error(run_pacta(path(parent, ".env")))
})
