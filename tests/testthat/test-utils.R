test_that("local_pacta() creates a pacta project locally", {
  dir <- tempdir()

  local({
    local_pacta()
    expect_true(fs::file_exists(fs::path(dir, ".env")))
    expect_true(fs::dir_exists(fs::path(dir, "input")))
    expect_true(fs::dir_exists(fs::path(dir, "output")))
  })

  expect_false(fs::file_exists(fs::path(dir, ".env")))
  expect_false(fs::dir_exists(fs::path(dir, "input")))
  expect_false(fs::dir_exists(fs::path(dir, "output")))
})

test_that("create_pacta() creates .env, input/, and output/", {
  dir <- withr::local_tempdir("pacta_")

  expect_false(fs::file_exists(fs::path(dir, ".env")))
  expect_false(fs::dir_exists(fs::path(dir, "input")))
  expect_false(fs::dir_exists(fs::path(dir, "output")))

  create_pacta(dir)

  expect_true(fs::file_exists(fs::path(dir, ".env")))
  expect_true(fs::dir_exists(fs::path(dir, "input")))
  expect_true(fs::dir_exists(fs::path(dir, "output")))
})

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

test_that("create_io() creates directories input/ and output/", {
  env <- local_env()
  create_io(env)

  expect_true(fs::dir_exists(fs::path_temp("input")))
  expect_true(fs::dir_exists(fs::path_temp("output")))
})

test_that("local_env() defaults to creating an '.env' file in the tempdir()", {
  env <- local_env()
  expect_true(fs::file_exists(fs::path_temp(".env")))
})

test_that("local_env() can create a good env file, with any name", {
  withr::local_tempdir()

  local_env(path = "myenv", output = "a/b/c")
  expect_equal(path_env("PACTA_OUTPUT", env = "myenv"), "a/b/c")
})

test_that("path_env() returns the expected path", {
  env <- local_env()
  expect_equal(fs::path_file(path_env("PACTA_INPUT", env)), "input")
  expect_equal(fs::path_file(path_env("PACTA_OUTPUT", env)), "output")
  expect_equal(fs::path_file(path_env("PACTA_DATA", env)), "pacta-data")
})
