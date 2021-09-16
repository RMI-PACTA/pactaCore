test_that("with scripts 1:2 produces output", {
  skip_on_ci()
  skip_on_cran()
  skip_slow_tests()

  results <- run_web_tool(x = 1:2)
  reference <- private_path("web_tool")
  dir_copy(results, reference, overwrite = TRUE)

  datasets <- enlist_rds(reference)
  dimensions <- lapply(datasets, dim)
  expect_snapshot(dimensions)
  classes <- classes(datasets)
  expect_snapshot(classes)
})
