# Like purrr::walk
walk <- function(.x, .f, ...) {
  lapply(.x, .f, ...)
  invisible(.x)
}

# Like rlang::`%||%`
`%||%` <- function(x, y) {
  if (is.null(x)) {
    y
  } else {
    x
  }
}

#' Create a working_dir/ directory with the folders structure that pacta expects
#'
#' @param dir String. Path to where to create a pacta project.
#'
#' @examples
#' dir <- tempdir()
#' create_working_dir(dir)
#' dir_tree(path(dir, "working_dir"))
#' @noRd
create_working_dir <- function(dir = tempdir()) {
  dir_create(path(dir, working_dir_paths()))
  invisible(dir)
}

abort_if_dir_exists <- function(dir) {
  if (dir_exists(dir)) {
    stop("This directory must not exist but it does:\n", dir, call. = FALSE)
  }

  invisible(dir)
}

portfolio_names <- function(dir, regexp) {
  csv <- fs::dir_ls(dir, regexp = regexp)
  fs::path_ext_remove(fs::path_file(csv))
}

extdata_path <- function(..., mustWork = TRUE) {
  system.file("extdata", ..., package = "pactaCore", mustWork = mustWork)
}

context_path <- function(..., mustWork = FALSE) {
  extdata_path("context", ..., mustWork = mustWork)
}

results_path <- function(parent, ..., regexp = portfolio_pattern()) {
  portfolios <- portfolio_names(path(parent, "input"), regexp = regexp)
  path(parent, "output", "working_dir", "40_Results", portfolios, ...)
}

working_dir_paths <- function(portfolio_name = example_input_name()) {
  subdir <- c(
    "10_Parameter_File",
    "00_Log_Files",
    path("00_Log_Files", portfolio_name),
    "30_Processed_Inputs",
    path("30_Processed_Inputs", portfolio_name),
    "40_Results",
    path("40_Results", portfolio_name),
    "20_Raw_Inputs",
    "50_Outputs",
    path("50_Outputs", portfolio_name)
  )

  path("working_dir", subdir)
}

example_input_paths <- function() {
  extdata_path(
    sprintf(c("%s.csv", "%s_PortfolioParameters.yml"), example_input_name())
  )
}

# Abstract this low level detail
example_input_name <- function() {
  "TestPortfolio_Input"
}

# Abstract this low level detail
portfolio_pattern <- function() {
  "_Input[.]csv"
}

skip_slow_tests <- function() {
  testthat::skip_on_cran()
  skipping_slow_tests <- as.logical(Sys.getenv("PACTA_SKIP_SLOW_TESTS"))
  testthat::skip_if(skipping_slow_tests)
}

path_env <- function(envvar = pacta_envvar(), env = NULL) {
  unlist(lapply(envvar, path_env_once, env = env))
}

path_env_once <- function(envvar, env = NULL) {
  env <- env %||% path_wd(".env")

  envvar <- paste0("^", envvar, "=")
  var_path <- grep(envvar, readLines(env), value = TRUE)
  sub(envvar, "", var_path)
}

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

#' Create an environment file
#'
#' @param path String. Path to the environment file you want to create.
#' @param ... Passed on to `create_env()`.
#' @param envir Must be passed on to `withr::defer()`.
#'
#' @examples
#' env <- withr::local_file(".env")
#'
#' create_env(
#'   path = env,
#'   input = "a/b",
#'   output = "c/d",
#'   data = "e/f/pacta-data"
#' )
#' file_exists(env)
#' readLines(env)
#' @noRd
create_env <- function(path = path_temp(".env"),
                       output = path_temp("output"),
                       input = path_temp("input"),
                       data = getenv_data()) {
  envvars <- pacta_envvar("output", "input", "data")
  dirs <- c(output, input, data)

  parent <- path_dir(path)
  if (!dir_exists(parent)) {
    dir_create(parent, recurse = TRUE)
  }

  writeLines(sprintf("%s=%s", envvars, dirs), con = path)

  invisible(path)
}

#' Update inst/extdata/context/pacta_legacy.R with scripts from PACTA_analysis
#'
#' @examples
#' update_pacta_legacy()
#' @noRd
update_pacta_legacy <- function(file = context_path("pacta_legacy.R")) {
  scripts <- paste0(
    "https://raw.githubusercontent.com/2DegreesInvesting/PACTA_analysis/d0458024b1a3becec1c165dc68ab05ae9c1e16cd/",
    # "https://raw.githubusercontent.com/2DegreesInvesting/PACTA_analysis/master/",
    "web_tool_script_", 1:2, ".R"
  )
  code <- unlist(lapply(scripts, readLines))
  writeLines(code, file)

  invisible(file)
}
