#' Enable/dissable slow tests
#'
#' @export
#' @keywords internal
#'
#' @examples
#' if (interactive()) {
#'   enable_slow_tests()
#'   dissable_slow_tests()
#' }
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
  skip_on_cran()
  skip_if(skipping_slow_tests())
}

skipping_slow_tests <- function() {
  as.logical(Sys.getenv("PACTA_SKIP_SLOW_TESTS"))
}
