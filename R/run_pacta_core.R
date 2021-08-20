#' Run pacta core
#' @export
#'
#' @examples
#' run_pacta_core()
#' # Same
#' run_pacta_core(env = create_env_from_renviron())
#'
#' env <- create_env()
#' run_pacta_core(env)
#' @noRd
run_pacta_core <- function(env = NULL) {
  env <- env %||% create_env_from_renviron()

  withr::local_dir(context_path())
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
