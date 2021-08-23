test_that("path_env() reads default '.env' file implicitely", {
  env <- withr::local_file(".env")
  writeLines("PACTA_OUTPUT=a/b/c", env)

  expect_equal(path_env("PACTA_OUTPUT"), "a/b/c")
})

test_that("path_env() fails to read no-default environment file implicitely", {
  env <- withr::local_file("myenv")
  writeLines("PACTA_OUTPUT=a/b/c", env)
  suppressWarnings(expect_error(path_env("PACTA_OUTPUT")))
})

test_that("path_env() returns the expected path", {
  env <- local_env()
  expect_equal(fs::path_file(path_env("PACTA_INPUT", env)), "input")
  expect_equal(fs::path_file(path_env("PACTA_OUTPUT", env)), "output")
  expect_equal(fs::path_file(path_env("PACTA_DATA", env)), "pacta-data")
})
