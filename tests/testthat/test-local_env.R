test_that("local_env() defaults to creating an '.env' file in the tempdir()", {
  env <- local_env()
  expect_true(fs::file_exists(fs::path_temp(".env")))
})

test_that("local_env() can create a good env file, with any name", {
  withr::local_tempdir()

  local_env(path = "myenv", output = "a/b/c")
  expect_equal(path_env("PACTA_OUTPUT", env = "myenv"), "a/b/c")
})
