extdata_path <- function(..., mustWork = TRUE) {
  system.file("extdata", ..., package = "pactaCore", mustWork = mustWork)
}

context_path <- function(..., mustWork = FALSE) {
  extdata_path("context", ..., mustWork = mustWork)
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
  testthat::skip_if()
}
