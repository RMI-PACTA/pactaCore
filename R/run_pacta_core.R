#' Run the core steps of the PACTA methodology
#'
#' @param env String. Path to an environment file with pacta variables.
#'
#' @return Called for its side effect. Returns the first argument inbisibly.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   dir <- fs::path_abs("../pacta")
#'   local_pacta(dir)
#'
#'   env <- fs::path(dir, ".env")
#'   readLines(env)
#'
#'   run_pacta_core(env)
#'
#'   fs::dir_tree(dir)
#' }
run_pacta_core <- function(env = ".env") {
  withr::local_dir(context_path())

  if (!ok_working_dir()) {
    stop(
      "All working_dir directories must exist.\n",
      "Do you need to `create_working_dir()` and maybe update the image?",
      call. = FALSE
    )
  }

  command <- sprintf("docker-compose --env-file %s up", env)
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
