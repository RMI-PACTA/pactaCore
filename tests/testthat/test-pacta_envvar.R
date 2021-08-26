test_that("output the envvars that match the given patterns in order", {
  expect_equal(pacta_envvar(), paste0("PACTA_", c("DATA", "INPUT", "OUTPUT")))
  expect_equal(pacta_envvar("out", "in"), paste0("PACTA_", c("OUTPUT", "INPUT")))
})
