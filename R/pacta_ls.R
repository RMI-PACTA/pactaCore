#' Explore pacta paths
#'
#' @param env String. Path to environment file. `NULL` defaults to ".env".
#' @param ... Passed on to `fs::dir_ls()`.
#'
#' @export
#' @keywords internal
#'
#' @examples
#' dir <- local_pacta()
#' withr::local_dir(dir)
#'
#' pacta_ls()
#' pacta_info()
#'
#' pacta_permissions(recurse = TRUE)
pacta_ls <- function(env = NULL, ...) {
  env <- env %||% fs::path_wd(".env")
  names(env) <- env

  dirs <- path_env(pacta_envvar())
  names(dirs) <- dirs
  dirs <- lapply(dirs, fs::dir_ls, ...)

  append(env, dirs)
}

#' @rdname pacta_ls
#' @export
#' @keywords internal
pacta_permissions <- function(env = NULL, ...) {
  show_permissions <- function(x) x[c("path", "permissions", "user", "group")]
  out <- lapply(pacta_info(env = env, ...), show_permissions)
  Reduce(rbind, out)
}

#' @rdname pacta_ls
#' @export
#' @keywords internal
pacta_info <- function(env = NULL, ...) {
  lapply(pacta_ls(env = env, ...), fs::file_info)
}

