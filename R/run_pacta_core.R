#' Run PACTA on Docker
#'
#' @return Called for its side effects.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   run_pacta_core()
#' }
run_pacta_core <- function() {
  withr::local_dir(context_path())
  system("docker-compose up")
  invisible()
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
