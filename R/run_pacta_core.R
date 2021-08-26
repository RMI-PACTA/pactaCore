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
#'     pacta <- fs::path_home("pacta_tmp")
#'     local_pacta(pacta)
#'
#'     # Work from the pacta project for convenicenc
#'     withr::local_dir(pacta)
#'
#'     # The ".env" file specifies the setup for input/ output/ and private data
#'     readLines(".env")
#'
#'     # Before
#'     fs::dir_tree()
#'     run_pacta_core()
#'     # After
#'     fs::dir_tree()
#'   })
#' }
run_pacta_core <- function(env = ".env") {
  input <- path_env("PACTA_INPUT", env)
  output <- path_env("PACTA_OUTPUT", env)
  data <- path_env("PACTA_DATA", env)
  image_tag <- "pacta_core:0.0.0.9000"
  # r"()" was introduced in R 4.0.0
  command_arg <- r"(Rscript --vanilla -e '
    setwd("/bound")
    source("R/run_pacta.R")
    run_pacta()
  ')"

  withr::local_dir(context_path())
  abort_corrupt_working_dir()
  system(sprintf(
    "docker run --rm -v %s:/input -v %s:/output -v %s:/pacta-data:ro %s %s",
    input, output, data, image_tag, command_arg
  ))

  invisible(env)
}

abort_corrupt_working_dir <- function() {
  if (!ok_working_dir()) {
    stop(
      "All working_dir directories must exist.\n",
      "Do you need to `create_working_dir()` and maybe update the image?",
      call. = FALSE
    )
  }
}

abort_if_empty_dir <- function(dir) {
  is_empty <- identical(unname(unclass(fs::dir_ls(dir))), character(0))
  if (is_empty) {
    stop("This directory is unexpectedly empty:\n", dir, call. = FALSE)
  }

  invisible(dir)
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
