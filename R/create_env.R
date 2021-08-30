#' Create an environment file
#'
#' @param path String. Path to the environment file you want to create.
#' @param ... Passed on to `create_env()`.
#' @param envir Must be passed on to `withr::defer()`.
#'
#' @examples
#' env <- withr::local_file(".env")
#'
#' create_env(
#'   path = env,
#'   input = "a/b",
#'   output = "c/d",
#'   data = "e/f/pacta-data"
#' )
#' file_exists(env)
#' readLines(env)
#' @noRd
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
