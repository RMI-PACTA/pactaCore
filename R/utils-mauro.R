pacta_ls <- function(env = NULL, ...) {
  env <- env %||% path_wd(".env")
  names(env) <- env

  dirs <- path_env(pacta_envvar())
  names(dirs) <- dirs
  dirs <- lapply(dirs, dir_ls, ...)

  append(env, dirs)
}

pacta_permissions <- function(env = NULL, ...) {
  show_permissions <- function(x) x[c("path", "permissions", "user", "group")]
  out <- lapply(pacta_info(env = env, ...), show_permissions)
  Reduce(rbind, out)
}

pacta_info <- function(env = NULL, ...) {
  lapply(pacta_ls(env = env, ...), file_info)
}

delete_working_dir <- function() {
  dir_delete(context_path("working_dir"))
}

delete_pacta_tmp <- function() {
  dir_delete(path_home("pacta_tmp"))
}
