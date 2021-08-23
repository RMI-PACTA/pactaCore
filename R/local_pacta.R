#' Create a pacta project
#'
#' * `create_pacta()` creates a pacta project.
#' * `local_pacta()` creates a temporary pacta project.
#'
#' See https://testthat.r-lib.org/articles/test-fixtures.html#local-helpers.
#'
#' @param dir String. Path where to create pacta files and directories.
#' @param data String. Path to the private pacta-data/ directory.
#' @param env Must be passed on to `withr::defer()`.
#'
#' @keywords internal
#' @export
#'
#' @examples
#' dir <- fs::path(tempdir(), "pacta")
#'
#' # This local context is usually a call to test_that()
#'   local({
#'     local_pacta(dir)
#'     fs::dir_tree(dir, all = TRUE)
#'   })
#'
#'  fs::dir_exists(dir)
local_pacta <- function(dir = tempdir(),
                        data = getenv_data(),
                        envir = parent.frame()) {
  dir <- create_pacta(dir = dir, data = data)
  withr::defer(fs::dir_delete(dir), envir = envir)
  invisible(dir)
}

#' @rdname local_pacta
#' @export
#' @keywords internal
create_pacta <- function(dir = tempdir(), data = getenv_data()) {
  dir <- fs::path_abs(dir)

  if (!fs::dir_exists(dir)) {
    fs::dir_create(dir)
  }

  .env <- create_env(
    path = fs::path_abs(fs::path(dir, ".env")),
    input = fs::path_abs(fs::path(dir, "input")),
    output = fs::path_abs(fs::path(dir, "output")),
    data = data
  )
  create_io(.env)
  setup_inputs(.env)

  invisible(dir)
}

#' Get the environment variable "PACTA_DATA" or fail gracefully
#'
#' @export
#' @keywords internal
#'
#' @examples
#' getenv_data()
#'
#' Sys.setenv(PACTA_DATA = "")
#' try(getenv_data())
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
  fs::dir_create(io)
}

setup_inputs <- function(env = NULL) {
  paths <- extdata_path(portfolio_and_parameter_files())
  input <- path_env("PACTA_INPUT", env = env)
  walk_(paths, function(x) fs::file_copy(x, input, overwrite = TRUE))

  invisible(env)
}
