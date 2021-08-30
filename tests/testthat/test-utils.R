test_that("the code in PACTA_analysis hasn't changed", {
  pactaCore <- readLines(context_path("pacta_legacy.R"))
  PACTA_analysis <- readLines(update_pacta_legacy(tempfile()))

  expect_equal(pactaCore, PACTA_analysis)
})
