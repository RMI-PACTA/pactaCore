read_env <- function(env = root_path(find_env())) {
  if (!file_exists(env)) {
    stop(
      "The environment file must exist but it doesn't:\n",
      env, "\n",
      "* Did you forget to set it up?",
      call. = FALSE
    )
  }

  good_form <- "[[:alnum:]]+=[[:alnum:]]+"
  is_ok <- grepl(good_form, readLines(env))
  if (!all(is_ok)) {
    stop(
      "All lines in `env` must be like `key=value` but this one isn't:\n",
      readLines(env)[!is_ok][[1]],
      call. = FALSE
    )
  }

  readRenviron(env)
}
