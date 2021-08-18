#' Run PACTA on Docker
#'
#' @param output,input,data Strings. Path to the directories for output
#'   (results), input (portfolio and parameter files), and private data (the
#'   pacta-data' repository). Defaults to the paths of the directories output/,
#'   input/, and pacta-data/, under the working directory.
#'
#' @return Called for its side effects. Returns the first argument invisibly.
#'
#' @export
#' @examples
#' if (interactive()) {
#'   run_pacta_core()
#'
#'   run_pacta_core_with_env_file()
#' }
#'
#'
run_pacta_core <- function(output = NULL, input = NULL, data = NULL) {
  data <- data %||% fs::path_wd("pacta-data")
  input <- input %||% fs::path_wd("input")
  output <- output %||% fs::path_wd("output")

  env_file <- tempfile()
  writeLines(
    c(
      glue::glue("PACTA_DATA={data}"),
      glue::glue("PACTA_INPUT={input}"),
      glue::glue("PACTA_OUTPUT={output}")
    ),
    con = env_file
  )

  run_pacta_core_with_env_file(env_file)

  invisible(output)
}

#' @rdname run_pacta_core
run_pacta_core_with_env_file <- function(env_file = NULL) {
  env_file <- env_file %||% fs::path_wd(".env")

  withr::local_dir(context_path())
  command <- glue("docker-compose --env-file {env_file} up")
  system(command)

  invisible(env_file)
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

