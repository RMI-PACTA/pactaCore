path_env <- function(envvar = pacta_envvar(), env = NULL) {
  unlist(lapply(envvar, path_env_once, env = env))
}

path_env_once <- function(envvar, env = NULL) {
  env <- env %||% fs::path_wd(".env")

  envvar <- paste0("^", envvar, "=")
  var_path <- grep(envvar, readLines(env), value = TRUE)
  sub(envvar, "", var_path)
}
