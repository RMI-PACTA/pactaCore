#' Explore pacta paths
#'
#' @param env String. Path to environment file. `NULL` defaults to ".env".
#' @param ... Passed on to `fs::dir_ls()`.
#'
#' @examples
#' dir <- local_pacta()
#' withr::local_dir(dir)
#'
#' pacta_ls(env)
#' pacta_info()
#' pacta_permission(recurse = TRUE)
pacta_permission <- function(env = NULL, ...) {
  show_permissions <- function(x) x[c("path", "permissions", "user", "group")]
  lapply(pacta_info(env = env, ...), show_permissions)
}

pacta_info <- function(env = NULL, ...) {
  lapply(pacta_ls(env = env, ...), fs::file_info)
}

pacta_ls <- function(env = NULL, ...) {
  env <- env %||% fs::path_wd(".env")
  names(env) <- env

  dirs <- path_env(pacta_envvar())
  names(dirs) <- dirs
  dirs <- lapply(dirs, fs::dir_ls, ...)

  append(env, dirs)
}
