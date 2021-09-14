test_that("with scripts 1:2 produces output", {
  skip_on_ci()
  skip_on_cran()
  skip_slow_tests()

  results <- parent_path("PACTA_analysis", "working_dir", "40_Results")
  if (dir_exists(results)) dir_delete(results)
  dir_create(results)

  run_web_tool(path = parent_path("PACTA_analysis"), x = 1:2)

  reference <- private_path("web_tool")
  dir_copy(results, reference, overwrite = TRUE)

  datasets <- enlist_rds(reference)
  dimensions <- lapply(datasets, dim)
  expect_snapshot(dimensions)
  classes <- classes(datasets)
  expect_snapshot(classes)
})

test_that("without siblings errors gracefully", {
  expect_snapshot_error(run_web_tool("/bad/path"))
})
