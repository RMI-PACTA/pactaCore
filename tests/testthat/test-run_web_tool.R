test_that("creates the expected results", {
  skip_on_ci()
  skip_on_cran()
  skip_slow_tests()

  results <- path_parent("PACTA_analysis", "working_dir", "40_Results")
  abort_if_not_empty_dir(results)
  fs::dir_create(results)

  # FIXME: Fails because results are owned by root
  # withr::defer(dir_delete(results))

  # TODO: Replace legacy code with pactaCore
  run_web_tool()
  files <- dir_ls(results, type = "file", recurse = TRUE)
  datasets <- lapply(files, readRDS)
  names(datasets) <- path_ext_remove(path_file(names(datasets)))

  expect_snapshot(datasets)
})
