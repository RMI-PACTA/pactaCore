local_pacta <- function(dir = fs::path_temp(),
                        data = NULL,
                        envir = parent.frame()) {
  dir <- create_pacta(dir = dir, data = data)
  withr::defer(fs::dir_delete(dir), envir = envir)
  invisible(dir)
}

create_pacta <- function(dir = tempdir(), data = NULL) {
  if (!fs::dir_exists(dir)) {
    fs::dir_create(dir)
  }

  .env <- create_env(
    path = fs::path_abs(fs::path(dir, ".env")),
    input = fs::path_abs(fs::path(dir, "input")),
    output = fs::path_abs(fs::path(dir, "output")),
    data = data %||% getenv_data()
  )
  create_io(.env)
  setup_inputs(.env)

  invisible(dir)
}

getenv_data <- function() {
  out <- Sys.getenv("PACTA_DATA", unset = "")

  unset <- identical(out, "")
  if (unset) {
    stop(
      "The environment PACTA_DATA must be set.\n",
      "Do you need to set it in .Renviron? (see `?usethis::edit_r_environ()`",
      call. = FALSE
    )
  }

  out
}

#' Help create an ephemeral environment file.
#'
#' See https://testthat.r-lib.org/articles/test-fixtures.html#local-helpers.
#'
#' @param path String. Path to the environment file you want to create.
#' @param ... Passed on to `create_env()`.
#' @param env Must be passed on to `withr::dever()`.
#'
#' @examples
#' # This local context is usually a call to test_that()
#' local({
#'   env <- local_env()
#'   fs::file_exists(env)
#'   readLines(env)
#' })
#'
#' # Gone
#' fs::file_exists(env)
#' @noRd
local_env <- function(path = fs::path_temp(".env"), ..., envir = parent.frame()) {
  create_env(path, ...)
  withr::defer(fs::file_delete(path), envir = envir)
  invisible(path)
}

#' Help create an environment file from variables set in .Renviron
#' @examples
#' env <- create_env_from_renviron()
#' readLines(env)
#' @noRd
create_env_from_renviron <- function(path = fs::path_temp(".env")) {
  create_env(
    path,
    output = Sys.getenv("PACTA_OUTPUT"),
    input = Sys.getenv("PACTA_INPUT"),
    data = Sys.getenv("PACTA_DATA")
  )
}

#' Create an environment file with required variables
#' @examples
#' env <- create_env(output = "a", input = "b", data = "c")
#' env
#' writeLines(readLines(env))
#' @noRd
create_env <- function(path = fs::path_temp(".env"),
                       output = fs::path_temp("output"),
                       input = fs::path_temp("input"),
                       data = getenv_data()) {
  envvars <- pacta_envvar("output", "input", "data")
  dirs <- c(output, input, data)

  parent_exists <- fs::dir_exists(fs::path_dir(path))
  stopifnot(parent_exists)
  fs::file_exists(path)

  writeLines(sprintf("%s=%s", envvars, dirs), con = path)

  invisible(path)
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

path_env_once <- function(envvar = pacta_envvar(), env = NULL) {
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

#' Tree of directories set in an environment file
#'
#' @examples
#' file.exists(".env")
#'
#' tree_io()
#' # Same
#' tree_envvar(pacta_envvar("input", "output"))
#'
#' tree_envvar()
#' @noRd
tree_io <- function(env = NULL) {
  tree_envvar(pacta_envvar("input", "output"), env = env)
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
