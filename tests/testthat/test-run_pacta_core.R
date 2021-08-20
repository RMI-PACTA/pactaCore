test_that("with a pacta project in ../pacta creates working_dir", {
  pacta <- fs::path_dir(path_env("PACTA_OUTPUT"))
  local_pacta(pacta)
  env <- fs::path(pacta, ".env")

  results <- fs::path(pacta, "output", "working_dir", "40_Results")
  expect_false(fs::dir_exists(results))

  run_pacta_core(env)
  results <- fs::path(pacta, "output", "working_dir", "40_Results")
  # FIXME: Change ownership to user
  expect_true(fs::dir_exists(results))
})

test_that("with a pacta project in /tmp/ creates working_dir", {
  pacta <- local_pacta("/home/mauro/tmp/pacta")
  env <- fs::path(pacta, ".env")

  results <- fs::path(pacta, "output", "working_dir", "40_Results")
  expect_false(fs::dir_exists(results))

  run_pacta_core(env)
  results <- fs::path(pacta, "output", "working_dir", "40_Results")
  expect_true(fs::dir_exists(results))
})
