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

  classes <- lapply(datasets, function(x) unlist(lapply(x, class)))
  expect_snapshot(classes)

  datasets[] <- lapply(datasets, as.data.frame)
  expect_snapshot(datasets)
})

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
