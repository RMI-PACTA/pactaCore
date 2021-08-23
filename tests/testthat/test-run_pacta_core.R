test_that("with a pacta project defined in .Renviron creates working_dir", {
  skip_slow_tests()

  # FIXME: Tests seem to run as root/. maybe local_pacta() should check for
  # owner or best change it base on the owner of input/
  parent <- fs::path_dir(Sys.getenv("PACTA_OUTPUT"))
  local_pacta(parent)

  env <- fs::path(parent, ".env")

  results <- fs::path(parent, "output", "working_dir", "40_Results")
  expect_false(fs::dir_exists(results))

  run_pacta_core(env)
  expect_true(fs::dir_exists(results))
})

test_that("with a pacta project in /tmp/ creates working_dir", {
  skip_slow_tests()

  # FIXME: Something is wrong
  pacta <- local_pacta("/home/mauro/tmp/pacta")
  env <- fs::path(pacta, ".env")

  results <- fs::path(pacta, "output", "working_dir", "40_Results")
  expect_false(fs::dir_exists(results))

  run_pacta_core(env)
  results <- fs::path(pacta, "output", "working_dir", "40_Results")
  expect_true(fs::dir_exists(results))
})
