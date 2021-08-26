test_that("with pacta dir under user's home, creates the expected results", {
  skip_slow_tests()

  parent <- fs::path_home("pacta_tmp")
  abort_if_dir_exists(parent)
  local_pacta(parent)

  results <- fs::path(parent, "output", "working_dir", "40_Results")
  expect_false(fs::dir_exists(results))

  env <- fs::path(parent, ".env")
  run_pacta_core(env)
  expect_true(fs::dir_exists(results))
})
