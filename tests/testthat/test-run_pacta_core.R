test_that("with a pacta project defined in .Renviron creates working_dir", {
  skip_slow_tests()

  parent <- fs::path_dir(Sys.getenv("PACTA_OUTPUT"))
  # FIXME: Warn/stop if parent exists? Particularly because it'll be removed
  # on exit

  # Maybe remove this test all together when I manage to test on a tempdir()
  local_pacta(parent)

  env <- fs::path(parent, ".env")

  results <- fs::path(parent, "output", "working_dir", "40_Results")
  expect_false(fs::dir_exists(results))

  # FIXME: Seems to be using inst/extdata/context/.env
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
