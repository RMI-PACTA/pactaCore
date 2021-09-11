test_that("without siblings errors gracefully", {
  skip("tmp")
  expect_snapshot_error(run_web_tool("/bad/path"))
})

test_that("with scripts 1:2 produces output", {
  skip_on_ci()
  skip_on_cran()
  skip_slow_tests()

  results <- parent_path("PACTA_analysis", "working_dir", "40_Results")
  if (dir_exists(results)) dir_delete(results)
  dir_create(results)
  run_web_tool(path = parent_path("PACTA_analysis"), x = 1:2)

  reference <- private_path("web_tool")
  fs::dir_copy(results, reference, overwrite = TRUE)

  files <- dir_ls(reference, type = "file", recurse = TRUE)
  datasets <- lapply(files, readRDS)
  names(datasets) <- path_ext_remove(path_file(names(datasets)))

  dimensions <- lapply(datasets, dim)
  expect_snapshot(dimensions)

  classes <- lapply(datasets, function(x) unlist(lapply(x, class)))
  expect_snapshot(classes)
})
