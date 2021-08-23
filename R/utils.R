#' Explore pacta paths
#'
#' @param env String. Path to environment file. `NULL` defaults to ".env".
#' @param ... Passed on to `fs::dir_ls()`.
#'
#' @examples
#' permissions_pacta(recurse = TRUE)
#' info_pacta()
#' ls_pacta()
#' @noRd
permissions_pacta <- function(env = NULL, ...) {
  show_permissions <- function(x) x[c("path", "permissions", "user", "group")]
  lapply(info_pacta(env = env, ...), show_permissions)
}

info_pacta <- function(env = NULL, ...) {
  lapply(ls_pacta(env = env, ...), fs::file_info)
}

ls_pacta <- function(env = NULL, ...) {
  env <- env %||% fs::path_wd(".env")
  names(env) <- env

  dirs <- path_env(pacta_envvar())
  names(dirs) <- dirs
  dirs <- lapply(dirs, fs::dir_ls, ...)

  append(env, dirs)
}

#' Create input/ and output/ directories set in an environment file
#' @examples
#' env <- create_env()
#' create_io(env)
#' fs::dir_ls(tempdir(), all = TRUE, regexp = ".env|input|output")
#' @noRd
create_io <- function(env = NULL) {
  io <- path_env(pacta_envvar("input", "output"), env = env)
  fs::dir_create(io)
}

path_env <- function(envvar = pacta_envvar(), env = NULL) {
  unlist(lapply(envvar, path_env_once, env = env))
}

path_env_once <- function(envvar, env = NULL) {
  env <- env %||% fs::path_wd(".env")

  envvar <- paste0("^", envvar, "=")
  var_path <- grep(envvar, readLines(env), value = TRUE)
  sub(envvar, "", var_path)
}

#' Get enviroment variables succinctly and in a specific order
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

test_input_files <- function() {
  c("TestPortfolio_Input.csv", "TestPortfolio_Input_PortfolioParameters.yml")
}

# Empty the output/ directory set in an environment file
empty_output <- function(env = NULL) {
  output <- path_env("PACTA_OUTPUT", env = env)
  walk_(output, fs::dir_delete)
}

#' Path to installed files
#' @examples
#' extdata_path()
#'
#' try(extdata_path("context", "invalid"))
#'
#' extdata_path("context", "working_dir")
#'
#' extdata_path(c(
#'   "TestPortfolio_Input.csv",
#'   "TestPortfolio_Input_PortfolioParameters.yml"
#' ))
#' @noRd
extdata_path <- function(...) {
  system.file("extdata", ..., package = "pactaCore", mustWork = TRUE)
}

tree_envvar <- function(envvar = pacta_envvar(), env = NULL) {
  walk_(envvar, function(.x) fs::dir_tree(path_env(.x, env = env)))
  invisible(envvar)
}

# Like purrr::walk
walk_ <- function(.x, .f, ...) {
  lapply(.x, .f, ...)
  invisible(.x)
}

`%||%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

# Populate the input/ directory set in an environment file
setup_inputs <- function(env = NULL) {
  paths <- extdata_path(test_input_files())
  input <- path_env("PACTA_INPUT", env = env)
  walk_(paths, function(x) fs::file_copy(x, input, overwrite = TRUE))

  invisible(env)
}

#' Create the structure of pacta's working_dir/
#'
#' @examples
#' dir <- create_working_dir()
#' fs::dir_tree(fs::path(dir, "working_dir"))
create_working_dir <- function(dir = tempdir()) {
  fs::dir_create(fs::path(dir, working_dir_paths()))
  invisible(dir)
}

working_dir_paths <- function() {
    subdir <- c(
    "10_Parameter_File",
    "00_Log_Files",
    fs::path("00_Log_Files", "TestPortfolio_Input"),
    "30_Processed_Inputs",
    fs::path("30_Processed_Inputs", "TestPortfolio_Input"),
    "40_Results",
    fs::path("40_Results", "TestPortfolio_Input"),
    "20_Raw_Inputs",
    "50_Outputs",
    fs::path("50_Outputs", "TestPortfolio_Input")
  )

  fs::path("working_dir", subdir)
}

ok_working_dir <- function() {
  paths <- extdata_path("context", working_dir_paths())
  all(fs::dir_exists(paths))
}

skipping_slow_tests <- function() {
  as.logical(Sys.getenv("PACTA_SKIP_SLOW_TESTS"))
}

enable_slow_tests <- function() {
  path <- ".Renviron"
  out <- sub(
    "PACTA_SKIP_SLOW_TESTS=TRUE",
    "PACTA_SKIP_SLOW_TESTS=FALSE",
    readLines(path)
  )
  writeLines(out, path)

  message("* Restart R and load all.")
}

dissable_slow_tests <- function() {
  path <- ".Renviron"
  out <- sub(
    "PACTA_SKIP_SLOW_TESTS=FALSE",
    "PACTA_SKIP_SLOW_TESTS=TRUE",
    readLines(path)
  )
  writeLines(out, path)

  message("* Restart R and load all.")
}
