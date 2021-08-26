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

#' Create a working_dir/ directory with the folders structure that pacta expects
#'
#' @param dir String. Path to where to create a pacta project.
#'
#' @export
#' @keywords internal
#'
#' @examples
#' dir <- tempdir()
#' create_working_dir(dir)
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

portfolio_and_parameter_files <- function() {
  c("TestPortfolio_Input.csv", "TestPortfolio_Input_PortfolioParameters.yml")
}

abort_if_dir_exists <- function(dir) {
  if (fs::dir_exists(dir)) {
    stop("`dir` must not exist but it does:", dir, call. = FALSE)
  }

  invisible(dir)
}
