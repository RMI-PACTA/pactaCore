test_that("creates the expected results", {
  skip_on_ci()
  skip_on_cran()
  skip_slow_tests()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  run_pacta(path(parent, ".env"))
  files <- dir_ls(results_path(parent), type = "file", recurse = TRUE)
  datasets <- lapply(files, readRDS)
  names(datasets) <- path_ext_remove(path_file(names(datasets)))

  expect_snapshot(datasets)
})

test_that("avoids overwritting output from a prevoius run", {
  skip_on_ci()
  skip_on_cran()
  parent <- path_home("pacta_tmp")
  local_pacta(parent)

  # Pretend we have previous results
  dir_create(results_path(parent))

  expect_snapshot_error(run_pacta(path(parent, ".env")))
})
