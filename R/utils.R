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

portfolio_and_parameter_files <- function() {
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
