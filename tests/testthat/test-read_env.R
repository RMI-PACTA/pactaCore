test_that("with malformed line in .env errors gracefully", {
  env <- local_file(".env")
  writeLines("bad=", env)
  readLines(env)
  expect_error(read_env(env), "env.*must be.*key=value")
})
