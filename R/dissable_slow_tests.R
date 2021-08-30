#' Enable/dissable slow tests
#'
#' This function helps developers run slow tests only when necessary. It assumes
#' you have a file .Renviron (maybe at the project level) with the variable
#' `PACTA_SKIP_SLOW_TESTS` set to either `TRUE` or `FALSE`.
#'
#' @seealso `usethis::edit_r_environ("project")`.
#'
#' @examples
#' if (interactive()) {
#'   enable_slow_tests()
#'   dissable_slow_tests()
#' }
#' @noRd
enable_slow_tests <- function() {
  path <- ".Renviron"
  out <- sub(
    "PACTA_SKIP_SLOW_TESTS=TRUE",
    "PACTA_SKIP_SLOW_TESTS=FALSE",
    readLines(path)
  )
  writeLines(out, path)

  message("* Restart R and load all.")
}

dissable_slow_tests <- function() {
  path <- ".Renviron"
  out <- sub(
    "PACTA_SKIP_SLOW_TESTS=FALSE",
    "PACTA_SKIP_SLOW_TESTS=TRUE",
    readLines(path)
  )
  writeLines(out, path)

  message("* Restart R and load all.")
}

skip_slow_tests <- function() {
  testthat::skip_on_cran()
  testthat::skip_if(skipping_slow_tests())
}

skipping_slow_tests <- function() {
  as.logical(Sys.getenv("PACTA_SKIP_SLOW_TESTS"))
}
