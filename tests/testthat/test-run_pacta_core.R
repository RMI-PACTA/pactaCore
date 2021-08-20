test_that("creates working_dir", {
  dir <- local_pacta()
  env <- fs::path(dir, ".env")

  readLines(env)
  results <- fs::path(dir, "output", "working_dir", "40_Results")
  expect_false(fs::dir_exists(results))

  run_pacta_core(env)

  # FIXME: Where does the output/ go?
  expect_true(fs::dir_exists(fs::path(dir, "output", "working_dir")))
})
