test_that("creates a pacta project in the tempdir() directory", {
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

test_that("if PACTA_DATA is unset fails gracefully", {
  withr::local_envvar(c(PACTA_DATA=""))
  expect_error(local_pacta(), "need to set")
})
