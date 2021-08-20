test_that("create the expected output structure", {
  dir <- withr::local_dir(tempdir())
  dir <- local_pacta(dir)
  run_pacta(fs::path(dir, ".env"))

  has_results <- fs::dir_exists(fs::path(dir, "output", "working_dir", "40_Results"))
  expect_true(has_results)
})
