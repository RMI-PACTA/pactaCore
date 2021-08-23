#' Help create an ephemeral environment file
#'
#' See https://testthat.r-lib.org/articles/test-fixtures.html#local-helpers.
#'
#' @param path String. Path to the environment file you want to create.
#' @param ... Passed on to `create_env()`.
#' @param env Must be passed on to `withr::dever()`.
#'
#' @export
#' @keywords internal
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
#'   fs::file_exists(env)
#'   readLines(env)
#' })
#'
#' # Gone
#' fs::file_exists(env)
#'
#' # Persists
#' create_env(
#'   path = env,
#'   input = "a/b",
#'   output = "c/d",
#'   data = "e/f/pacta-data"
#' )
#' fs::file_exists(env)
#' readLines(env)
local_env <- function(path = fs::path_temp(".env"), ..., envir = parent.frame()) {
  create_env(path, ...)
  withr::defer(fs::file_delete(path), envir = envir)
  invisible(path)
}

#' @rdname local_env
#' @export
#' @keywords inernal
create_env <- function(path = fs::path_temp(".env"),
                       output = fs::path_temp("output"),
                       input = fs::path_temp("input"),
                       data = getenv_data()) {
  envvars <- pacta_envvar("output", "input", "data")
  dirs <- c(output, input, data)

  parent <- fs::path_dir(path)
  if (!fs::dir_exists(parent)) {
    fs::dir_create(parent, recurse = TRUE)
  }

  writeLines(sprintf("%s=%s", envvars, dirs), con = path)

  invisible(path)
}

#' Create a pacta environment file from pacta variables set in .Renviron
#'
#' @param path String. Path to the environment file you want to create.
#'
#' @export
#' @keywords internal
#'
#' @examples
#' env <- create_env_from_renviron()
#' readLines(env)
create_env_from_renviron <- function(path = fs::path_temp(".env")) {
  create_env(
    path,
    output = Sys.getenv("PACTA_OUTPUT"),
    input = Sys.getenv("PACTA_INPUT"),
    data = Sys.getenv("PACTA_DATA")
  )
}
