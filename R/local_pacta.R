#' Create a pacta project
#'
#' * `create_pacta()` creates a pacta project.
#' * `local_pacta()` creates a temporary pacta project.
#'
#' @seealso
#'   https://testthat.r-lib.org/articles/test-fixtures.html#local-helpers.
#'
#' @param dir String. Path where to create pacta files and directories.
#' @param input_paths String. Path to portfolio and parameter files.
#' @param data String. Path to the private pacta-data/ directory.
#' @param envir Must be passed on to `withr::defer()`.
#'
#' @examples
#' dir <- path(tempdir(), "pacta")
#' withr::local_envvar(c(PACTA_DATA = path(dir, "pacta-data")))
#'
#' # This local context is usually a call to test_that()
#' local({
#'   local_pacta(dir)
#'   dir_tree(dir, all = TRUE)
#' })
#'
#' dir_exists(dir)
#' @noRd
local_pacta <- function(dir = tempdir(),
                        input_paths = example_input_paths(),
                        data = getenv_data(),
                        envir = parent.frame()) {
  dir <- create_pacta(dir = dir, data = data, input_paths = input_paths)
  withr::defer(dir_delete(dir), envir = envir)
  invisible(dir)
}

create_pacta <- function(dir = tempdir(),
                         input_paths = example_input_paths(),
                         data = getenv_data()) {
  dir <- path_abs(dir)

  if (!dir_exists(dir)) {
    dir_create(dir)
  }

  env <- create_env(
    path = path_abs(path(dir, ".env")),
    input = path_abs(path(dir, "input")),
    output = path_abs(path(dir, "output")),
    data = data
  )
  create_io(env)
  copy_input_paths(env, input_paths = example_input_paths())

  invisible(dir)
}

#' Get the environment variable "PACTA_DATA" or fail gracefully
#'
#' @examples
#' getenv_data()
#'
#' Sys.setenv(PACTA_DATA = "")
#' try(getenv_data())
#' @noRd
getenv_data <- function() {
  out <- Sys.getenv("PACTA_DATA", unset = "")

  unset <- identical(out, "")
  if (unset) {
    stop(
      "The environment PACTA_DATA must be set.\n",
      "Do you need to set it in .Renviron? (see `?usethis::edit_r_environ()`",
      call. = FALSE
    )
  }

  out
}

create_io <- function(env = NULL) {
  io <- path_env(pacta_envvar("input", "output"), env = env)
  dir_create(io)
  invisible(env)
}

copy_input_paths <- function(env = NULL, input_paths = example_input_paths()) {
  input <- path_env("PACTA_INPUT", env = env)
  walk(input_paths, function(x) file_copy(x, input, overwrite = TRUE))
  invisible(env)
}
