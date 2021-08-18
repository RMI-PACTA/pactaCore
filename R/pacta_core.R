#' Run PACTA on Docker
#'
#' @param output,input,data Strings. Path to the directories for output
#'   (results), input (portfolio and parameter files), and private data (the
#'   pacta-data' repository). Defaults to the paths of the directories output/,
#'   input/, and pacta-data/, under the working directory.
#' @param env String. Path to environment file giving the path to the output/,
#' input/, and pacta-data/ directories. For example:
#' ```bash
#' PACTA_DATA=/home/mauro/git/pacta/pacta-data
#' PACTA_INPUT=/home/mauro/git/pacta/input
#' PACTA_OUTPUT=/home/mauro/git/pacta/output
#' ````
#'
#' @return Called for its side effects. Returns the first argument invisibly.
#'
#' @export
#' @examples
#' if (interactive()) {
#'   pacta_core()
#'
#'   ouput <- pacta_core(
#'     output = "~/git/pacta/output",
#'     input = "~/git/pacta/input",
#'     data = "~/git/pacta/pacta-data"
#'   )
#'   fs::dir_tree(output)
#'
#'   fs::file_exists(".env")  # expect TRUE
#'   pacta_core_with_env()
#' }
#'
#'
pacta_core <- function(output = NULL, input = NULL, data = NULL) {
  env <- write_env(
    output %||% fs::path_wd("output"),
    input %||% fs::path_wd("input"),
    data %||% fs::path_wd("pacta-data")
  )
  pacta_core_with_env(env)

  invisible(output)
}

write_env <- function(output, input, data) {
  env <- tempfile()
  writeLines(
    c(
      glue::glue("PACTA_DATA={data}"),
      glue::glue("PACTA_INPUT={input}"),
      glue::glue("PACTA_OUTPUT={output}")
    ),
    con = env
  )
}

#' @rdname pacta_core
#' @export
pacta_core_with_env <- function(env = NULL) {
  env <- env %||% fs::path_wd(".env")

  withr::local_dir(context_path())
  command <- glue("docker-compose --env-file {env} up")
  system(command)

  invisible(env)
}

#' Help create paths into the build context of the Docker image
#'
#' @inheritParams fs::path
#' @return A vector of class `r toString(class(context_path()))`.
#'
#' @examples
#' context_path()
#' fs::dir_ls(context_path("working_dir"))
#' @noRd
context_path <- function(...) {
  fs::path(system.file("extdata", "context", package = "pactaCore"), ...)
}

