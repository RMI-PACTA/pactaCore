test_that("creates working_dir", {
  x <- local_pacta()
  env <- fs::path(x, ".env")
  run_pacta_core(env)
})
