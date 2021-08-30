#' Help create an environment file
#'
#' * `create_env()` creates an environment file.
#' * `local_env()` creates a temporary environment file -- available only in the
#' local context where `local_env()` is called.
#'
#' @seealso https://testthat.r-lib.org/articles/test-fixtures.html#local-helpers.
#'
#' @param path String. Path to the environment file you want to create.
#' @param ... Passed on to `create_env()`.
#' @param envir Must be passed on to `withr::defer()`.
#'
#' @examples
#' # The local context is usually a call to test_that()
#' env <- tempfile("env_")
#' local({
#'   env <- local_env(
#'     path = env,
#'     input = "a/b",
#'     output = "c/d",
#'     data = "e/f/pacta-data"
#'   )
#'   file_exists(env)
#'   readLines(env)
#' })
#'
#' # Gone
#' file_exists(env)
#'
#' # Persists
#' create_env(
#'   path = env,
#'   input = "a/b",
#'   output = "c/d",
#'   data = "e/f/pacta-data"
#' )
#' file_exists(env)
#' readLines(env)
#' @noRd
local_env <- function(path = path_temp(".env"), ..., envir = parent.frame()) {
  create_env(path, ...)
  withr::defer(file_delete(path), envir = envir)
  invisible(path)
}

create_env <- function(path = path_temp(".env"),
                       output = path_temp("output"),
                       input = path_temp("input"),
                       data = getenv_data()) {
  envvars <- pacta_envvar("output", "input", "data")
  dirs <- c(output, input, data)

  parent <- path_dir(path)
  if (!dir_exists(parent)) {
    dir_create(parent, recurse = TRUE)
  }

  writeLines(sprintf("%s=%s", envvars, dirs), con = path)

  invisible(path)
}
