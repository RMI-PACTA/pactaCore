test_that("outputs the expected named list", {
  dir <- local_pacta()
  withr::local_dir(dir)

  out <- pacta_ls()

  expect_type(out, "list")
  names <- sort(fs::path_file(names(out)))
  expect_equal(names, c(".env", "input", "output", "pacta-data"))
})
