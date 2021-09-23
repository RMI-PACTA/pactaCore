#' Create a pacta projects
#'
#' These functions create a template for your pacta project, populated with
#' a demo portfolio and parameter file. They differ in whether or not the project
#' persists after you exit the local context that calls these functions:
#' * `create_pacta()` creates a persistent pacta project. This is what you would
#' normally use in real projects.
#' * `local_pacta()` creates an ephemeral pacta project, that is auto-removed
#' when you exit the local context that calls `local_pacta()`. This is what you
#' would normally use in examples and tests.
#'
#' @param dir String. Path where to create pacta files and directories.
#' @param input_paths String. Path to portfolio and parameter files.
#' @param data String. Path to the private pacta-data/ directory.
#' @param envir Must be passed on to `withr::defer()`.
#'
#' @seealso
#' https://testthat.r-lib.org/articles/test-fixtures.html#local-helpers.
#'
#' @return These functions are called for their side effect. They return the
#'   first argument invisibly.
#' @export
#'
#' @examples
#' library(fs)
#'
#' pacta <- tempfile("somewhere")
#' create_pacta(pacta, data = "path/to/pacta-data")
#' dir_tree(pacta)
#' readLines(path(pacta, ".env"))
#'
#' # Auto-remove the pacta project when you exit the local context
#' pacta_ephemeral <- tempfile("somewhere")
#' local({
#'   local_pacta(pacta_ephemeral)
#'   dir_tree(pacta_ephemeral, all = TRUE)
#'   dir_exists(pacta_ephemeral)
#' })
#' dir_exists(pacta_ephemeral)
create_pacta <- function(dir = tempfile(pattern = "pacta_"),
                         input_paths = example_input_paths(),
                         data = get_env("PACTA_DATA")) {
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

#' @rdname create_pacta
#' @export
local_pacta <- function(dir = tempfile("pacta_"),
                        input_paths = example_input_paths(),
                        data = get_env("PACTA_DATA"),
                        envir = parent.frame()) {
  dir <- create_pacta(dir = dir, data = data, input_paths = input_paths)
  withr::defer(dir_delete(dir), envir = envir)
  invisible(dir)
}

#' Path to an example portfolio and parameter file
#'
#' @return String. A vector of paths to example portfolio and parameter files.
#' @export
#'
#' @keywords helpers
#'
#' @examples
#' example_input_paths()
example_input_paths <- function() {
  extdata_path(
    sprintf(c("%s.csv", "%s_PortfolioParameters.yml"), example_input_name())
  )
}

# Abstract this low level detail
example_input_name <- function() {
  "TestPortfolio_Input"
}

#' Get the value of an environment variable, or fail with an informative error
#'
#' @param var String. The name of an environment variable, e.g. "PACTA_DATA".
#'
#' @return String. The value of the environment value (or an informative error).
#' @export
#'
#' @family helpers
#'
#' @examples
#' get_env("SHELL")
#' try(get_env("BAD"))
get_env <- function(var) {
  val <- Sys.getenv(var)

  if (identical(val, "")) {
    stop(
      "The environment variable `", var, "` must be set but isn't.\n",
      "Do you need to set it in .Renviron or .env?",
      call. = FALSE
    )
  }

  val
}

create_io <- function(env = NULL) {
  io <- path_env(pacta_envvar("input", "output"), env = env)
  dir_create(io)
  invisible(env)
}

copy_input_paths <- function(env = NULL, input_paths = example_input_paths()) {
  input <- path_env("PACTA_INPUT", env = env)
  walk(input_paths, file_duplicate, input)
  invisible(env)
}
