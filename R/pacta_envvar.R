#' Get enviroment variables succinctly and in a specific order
#'
#' ... Strings. Text to match the name of the environment variables of a pacta
#' project.
#'
#' @examples
#' pacta_envvar()
#' pacta_envvar("out", "in")
#' pacta_envvar("in", "out")
#' @noRd
pacta_envvar <- function(...) {
  patterns <- list(...)
  if (identical(patterns, list())) {
    patterns <- ""
  }
  unlist(lapply(patterns, function(x) pacta_envvar_once(x)))
}

pacta_envvar_once <- function(pattern = "") {
  envvars <- paste0("PACTA_", c("DATA", "INPUT", "OUTPUT"))
  grep(pattern, envvars, value = TRUE, ignore.case = TRUE)
}
