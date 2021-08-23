#' Run pacta core
#' @export
#'
#' @examples
#' if (interactive()) {
#'   dir <- withr::local_tempdir("pacta")
#'   withr::local_dir(dir)
#'   local_pacta(dir)
#'
#'   fs::dir_tree(all = TRUE)
#'   readLines(".env")
#'
#'   run_pacta_core(".env")
#' }
run_pacta_core <- function(env) {
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
