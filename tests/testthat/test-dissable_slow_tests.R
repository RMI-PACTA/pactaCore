test_that("dissables slow tests", {
  withr::local_file(".Renviron")

  writeLines("PACTA_SKIP_SLOW_TESTS=FALSE", ".Renviron")
  suppressMessages(dissable_slow_tests())
  expect_true(grepl("TRUE$", readLines(".Renviron")))
})
test_that("enables slow tests", {
  withr::local_file(".Renviron")

  writeLines("PACTA_SKIP_SLOW_TESTS=TRUE", ".Renviron")
  suppressMessages(enable_slow_tests())
  expect_true(grepl("FALSE$", readLines(".Renviron")))
})
