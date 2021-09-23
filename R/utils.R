#' Use a function to pair-wise compare each element in two lists
#'
#' @examples
#' compare_with(
#'   names,
#'   list(a = data.frame(x = 1)),
#'   list(a = data.frame(y = 1))
#' )
#' @noRd
compare_with <- function(f = dim,
                         new = enlist_rds(private_path("pacta_core")),
                         old = enlist_rds(private_path("web_tool"))) {
  for (i in seq_along(old)) {
    print(paste(names(new)[[i]]))

    # Leaving the duplication to preserve the name of the function so we get
    # "Different names" -- not "Different X[[i]]"
    compare_with_once(f, new[[i]], old[[i]])
  }

  invisible(new)
}

compare_with_once <- function(f = dim, new, old) {
  # Quiet printed output, e.g. of str()
  sink(tempfile())
  same_f <- identical(f(new), f(old))
  sink()

  if (!same_f) {
    message(
      "Different ", deparse(substitute(f)), ":\n",
      "* new: ", toString(f(new)), "\n",
      "* old: ", toString(f(old))
    )
  }

  invisible(new)
}

#' A vectorized version of waldo::compare()
#'
#' Defaults to comparing private results between the web tool and this package.
#'
#' @param new,old A list of dataframes.
#' @param ... Passed to `waldos::compare()`
#'
#' @return Called for its side effect. Prints differences.
#'
#' @examples
#' new <- list(x = data.frame(a = 1, b = 1), x = data.frame(a = 1, b = 9))
#' old <- list(x = data.frame(a = 1, b = 1), x = data.frame(a = 1, b = 1))
#' compare_full(new, old)
#' compare_full(new, new)
#' @noRd
compare_full <- function(new = enlist_rds(private_path("pacta_core")),
                         old = enlist_rds(private_path("web_tool")),
                         ...) {
  for (i in seq_along(old)) {
    print(paste(names(new)[[i]], "(new)", "vs.", names(old)[[i]], "(old)"))
    try(
      print(waldo::compare(old[[i]], new[[i]], ...))
    )
  }

  invisible(new)
}

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
#' create_wd(dir)
#' dir_tree(path(dir, wd_path()))
#' @noRd
create_wd <- function(dir = tempdir()) {
  dir_create(path(dir, wd_paths()))
  invisible(dir)
}

portfolio_names <- function(dir, regexp) {
  csv <- dir_ls(dir, regexp = regexp)
  path_ext_remove(path_file(csv))
}

extdata_path <- function(..., mustWork = TRUE) {
  system.file("extdata", ..., package = "pactaCore", mustWork = mustWork)
}

legacy_path <- function(..., mustWork = FALSE) {
  extdata_path(legacy_dirname(), ..., mustWork = mustWork)
}

legacy_dirname <- function() {
  "context"
}

output_results_path <- function(parent, ..., regexp = portfolio_pattern()) {
  portfolios <- portfolio_names(path(parent, "input"), regexp = regexp)
  path(parent, "output", results_path(), portfolios, ...)
}

# Avoid littering the code base with specific paths we want to move away from
wd_path <- function(...) {
  path("working_dir", ...)
}

wd_paths <- function(portfolio_name = example_input_name()) {
  wd_path(c(
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
  ))
}

results_path <- function(...) {
  wd_path("40_Results", ...)
}

parameter_file_path <- function(...) {
  wd_path("10_Parameter_File", ...)
}

raw_inputs_path <- function(...) {
  wd_path("20_Raw_Inputs", ...)
}

# Abstract this low level detail
portfolio_pattern <- function() {
  "_Input[.]csv"
}

skip_slow_tests <- function() {
  skipping_slow_tests <- as.logical(
    Sys.getenv("PACTA_SKIP_SLOW_TESTS", unset = "TRUE")
  )
  testthat::skip_if(skipping_slow_tests)
}

path_env <- function(envvar = pacta_envvar(), env = NULL) {
  unlist(lapply(envvar, path_env_once, env = env))
}

abort_if_unset <- function(var, env) {
  if (identical(var, character(0))) {
    stop(
      "PACTA_INPUT must be set but isn't.\n",
      "Is this environment file as you expect?: ", path_abs(env),
      call. = FALSE
    )
  }

  invisible(var)
}

path_env_once <- function(envvar, env = NULL) {
  env <- env %||% path_wd(".env")

  envvar <- paste0("^", envvar, "=")
  var_path <- grep(envvar, readLines(env), value = TRUE)

  out <- sub(envvar, "", var_path)
  abort_if_unset(out, env)
  out
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
                       data = get_env("PACTA_DATA")) {
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
update_pacta_legacy <- function(file = legacy_path("pacta_legacy.R")) {
  scripts <- paste0(
    "https://raw.githubusercontent.com/2DegreesInvesting/PACTA_analysis/master/",
    "web_tool_script_", 1:2, ".R"
  )
  code <- unlist(lapply(scripts, readLines))
  writeLines(code, file)

  invisible(file)
}

expect_no_error <- function(object, ...) {
  testthat::expect_error(object, regexp = NA, ...)
}

abort_if_not_empty_dir <- function(path) {
  if (dir_exists(path) && !is_empty_dir(path)) {
    stop(
      "This directory must be empty but isn't:\n",
      path,
      call. = FALSE
    )
  }
  invisible(path)
}

is_empty_dir <- function(path) {
  identical(unname(unclass(dir_ls(path))), character(0))
}

abort_if_missing_inputs <- function(path) {
  portfolio <- dir_ls(path, regexp = "Input[.]csv")
  parameter <- dir_ls(path, regexp = "Input_PortfolioParameters[.]yml")
  missing_portfolio <- identical(unclass(unname(portfolio)), character(0))
  missing_parameter <- identical(unclass(unname(parameter)), character(0))
  if (missing_portfolio || missing_parameter) {
    stop(
      "The input/ directory must have at least one pair of files:\n",
      "* A porfolio file named <pair-name>_Input.csv.\n",
      "* A parameter file named <pair-name>_Input_PortfolioParameters.yml.\n",
      "Is your setup as per https://github.com/2DegreesInvesting/pactaCore?",
      call. = FALSE
    )
  }

  invisible(path)
}

abort_if_dir_exists <- function(dir) {
  if (dir_exists(dir)) {
    stop(
      "This directory must not exist:\n",
      dir, "\n",
      "* Do you need to remove it?",
      call. = FALSE
    )
  }

  invisible(dir)
}

stop_on_error <- function(exit_code) {
  if (exit_code > 0) {
    stop("This script threw an error.", call. = FALSE)
  }

  invisible(exit_code)
}

# Like here::here() and devtools::package_path() but without those dependencies
root_path <- function(...) {
  path(path_dir(path_dir(path_abs(testthat::test_path()))), ...)
}

parent_path <- function(...) {
  path(path_dir(root_path()), ...)
}

private_path <- function(...) {
  testthat::test_path("private", ...)
}

classes <- function(datasets) {
  lapply(datasets, function(x) unlist(lapply(x, class)))
}

# Read .rds files from a directory into a list
enlist_rds <- function(dir) {
  files <- dir_ls(dir, type = "file", recurse = TRUE)
  datasets <- lapply(files, readRDS)
  names(datasets) <- path_ext_remove(path_file(names(datasets)))
  datasets
}

dir_destroy <- function(path) {
  if (dir_exists(path)) dir_delete(path)
  invisible(path)
}

dir_move <- function(path, new_path) {
  system(paste("mv", path, new_path))
}

dir_duplicate <- function(path, new_path) {
  dir_copy(path, new_path, overwrite = TRUE)
}

file_duplicate <- function(path, new_path) {
  file_copy(path, new_path, overwrite = TRUE)
}

setup_source_data <- function(path = tempdir(), source, data) {
  dir_destroy(path)
  dir_create(path)
  check_setup_source_data(source, data)

  dir_copy(source, path)
  dir_copy(data, path)

  invisible(path)
}

abort_if_dir_doesnt_exist <- function(path) {
  if (!dir_exists(path)) {
    stop("This directory must exist but doesn't:\n", path, call. = FALSE)
  }

  invisible(path)
}

check_setup_source_data <- function(source, data) {
  abort_if_dir_doesnt_exist(source)
  tryCatch(abort_if_dir_doesnt_exist(data), error = function(e) {
    stop(
      conditionMessage(e), "\n",
      "* Did you setup the path to pacta-data/ correctly?",
      call. = FALSE
    )
  })

  invisible(source)
}

read_env <- function(env = root_path(find_env())) {
  if (!file_exists(env)) {
    stop(
      "The environment file must exist but it doesn't:\n",
      env, "\n",
      "* Did you forget to set it up?",
      call. = FALSE
    )
  }

  readRenviron(env)
}

find_env <- function() {
  user_is_rstudio <- identical(Sys.info()[["user"]], "rstudio")
  ifelse(user_is_rstudio, ".env_rstudio", ".env")
}

abort_if_missing_env <- function(env) {
  if (!file_exists(env)) {
    stop(
      "This environment file doesn't exist: ", env, "\n",
      "Is your setup as in https://github.com/2DegreesInvesting/pactaCore?",
      call. = FALSE
    )
  }
  invisible(path)
}
