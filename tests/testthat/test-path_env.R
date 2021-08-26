test_that("returns the expected path", {
  env <- local_env()
  expect_equal(fs::path_file(path_env("PACTA_INPUT", env)), "input")
  expect_equal(fs::path_file(path_env("PACTA_OUTPUT", env)), "output")
  expect_equal(fs::path_file(path_env("PACTA_DATA", env)), "pacta-data")
})

test_that("reads default '.env' file implicitely", {
  env <- withr::local_file(".env")
  writeLines("PACTA_OUTPUT=a/b/c", env)

  expect_equal(path_env("PACTA_OUTPUT"), "a/b/c")
})

test_that("fails to read no-default environment file implicitely", {
  env <- withr::local_file("myenv")
  writeLines("PACTA_OUTPUT=a/b/c", env)
  suppressWarnings(expect_error(path_env("PACTA_OUTPUT")))
})
