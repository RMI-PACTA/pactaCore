test_that("the code in PACTA_analysis hasn't changed", {
  skip_if_offline()
  pactaCore <- readLines(legacy_path("pacta_legacy.R"))
  PACTA_analysis <- readLines(update_pacta_legacy())

  expect_equal(pactaCore, PACTA_analysis)
})
