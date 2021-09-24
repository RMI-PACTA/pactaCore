#' Skip slow tests
#'
#' @param ... Arguments passed to `devtools::test()` and `devtools::check()`.
#'
#' @return Called for their side effect.
#' @export
#'
#' @family developer oriented
#'
#' @examples
#' \dontrun{
#'   test_fa
#' }
test_fast <- function(...) {
  withr::local_envvar(c(PACTA_SKIP_SLOW_TEST="TRUE"))
  devtools::test(...)
}

check_fast <- function(...) {
  withr::local_envvar(c(PACTA_SKIP_SLOW_TEST="TRUE"))
  devtools::check(...)
}

skip_slow_test <- function() {
  as.logical(Sys.getenv("PACTA_SKIP_SLOW_TEST", unset = "FALSE"))
}
