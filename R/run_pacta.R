#' Run the core steps of the PACTA methodology
#'
#' @param env String. Path to an environment file with pacta variables.
#'
#' @return Called for its side effect. Returns the first argument invisibly.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   local({
#'     # Create a toy, temporary pacta project
#'     pacta <- path_home("pacta_tmp")
#'     local_pacta(pacta)
#'
#'     # Work from the pacta project for convenicenc
#'     withr::local_dir(pacta)
#'
#'     # The ".env" file specifies the setup for input/ output/ and private data
#'     readLines(".env")
#'
#'     # Before
#'     dir_tree()
#'     run_pacta()
#'     # After
#'     dir_tree()
#'   })
#' }
run_pacta <- function(env = ".env") {
  run_pacta_impl(env)
  invisible(env)
}

# `code` allows injecting test code
run_pacta_impl <- function(env = ".env",
                           code = expression(system(docker_run))) {
  input <- path_env("PACTA_INPUT", env)
  output <- path_env("PACTA_OUTPUT", env)
  abort_if_missing_inputs(input)
  abort_if_not_empty_dir(results_path(fs::path_dir(output)))

  data <- path_env("PACTA_DATA", env)
  # r"()" was introduced in R 4.0.0
  command_arg <- r"(Rscript --vanilla -e '
    setwd("/bound")
    source("R/run_pacta_legacy.R")
    run_pacta_legacy()
  ')"

  withr::local_dir(context_path())

  local_working_dir()

  image_tag <- "pacta:0.0.0.9001"
  docker_build <- sprintf("docker build -t %s %s", image_tag, context_path())
  system(docker_build)

  docker_run <- sprintf(
    "docker run --rm -v %s:/input -v %s:/output -v %s:/pacta-data:ro %s %s",
    input, output, data, image_tag, command_arg
  )

  eval(code)

  invisible(env)
}

local_working_dir <- function(envir = parent.frame()) {
  working_dir_path <- context_path("working_dir")
  if (dir_exists(working_dir_path)) {
    stop(
      "working_dir/ already exists:\n",
      working_dir_path, "\n",
      "Do you need to delete the output of a previous run?",
      call. = FALSE
    )
  }

  create_working_dir(context_path())
  withr::defer(
    dir_delete(context_path("working_dir")),
    envir = envir
  )

  invisible(envir)
}
