test_that("creates an ephemeral pacta project", {
  skip_on_ci()
  skip_on_cran()
  dir <- tempfile()

  local({
    local_pacta(dir)
    expect_true(file_exists(path(dir, ".env")))
    expect_true(dir_exists(path(dir, "input")))
    expect_true(dir_exists(path(dir, "output")))
  })

  expect_false(file_exists(path(dir, ".env")))
  expect_false(dir_exists(path(dir, "input")))
  expect_false(dir_exists(path(dir, "output")))
})

test_that("if PACTA_DATA is unset fails gracefully", {
  withr::local_envvar(c(PACTA_DATA = ""))
  expect_error(local_pacta(), "PACTA_DATA.*must.*set")
})
