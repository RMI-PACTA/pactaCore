#' Run the web_tool
#'
#' @param path Path to source code, e.g. /path/to/PACTA_analysis
#' @param x Script(s) number web_tool_script_{1:3}.R
#' @noRd
run_web_tool <- function(results = path_temp("working_dir"),
                         source = parent_path("PACTA_analysis"),
                         data = parent_path("pacta-data"),
                         x = 1:3) {
  stopifnot(dir_exists(source), dir_exists(data))

  parent <- setup_source_data(path_dir(results), source, data)
  local_dir(path(parent, "PACTA_analysis"))

  if (dir_exists("working_dir")) dir_delete("working_dir")
  setup_working_dir(".")

  walk(web_tool_command()[x], function(x) stop_on_error(system(x)))
  system(paste("mv working_dir/40_Results", results))

  invisible(results)
}

setup_source_data <- function(path = tempdir(), source, data) {
  refresh_dir(path)

  dir_copy(source, path)
  dir_copy(data, path)

  invisible(path)
}

refresh_dir <- function(path) {
  if (dir_exists(path)) {
    dir_delete(path)
  }
  dir_create(path)

  invisible(path)
}

setup_working_dir <- function(path = ".") {
  create_working_dir(path)
  yml <- dir_ls(extdata_path(), regexp = "[.]yml")
  file_copy(yml, path("working_dir", "10_Parameter_File"))
  csv <- dir_ls(extdata_path(), regexp = "[.]csv")
  file_copy(csv, path("working_dir", "20_Raw_Inputs"))

  invisible(path)
}

# From PACTA_analysis/bin/run-r-scripts
web_tool_command <- function(portfolio = "TestPortfolio_Input") {
  command <- c(
    "Rscript --vanilla web_tool_script_1.R",
    "Rscript --vanilla web_tool_script_2.R",
    "Rscript --no-save --no-restore --no-site-file --no-environ web_tool_script_3.R"
  )
  paste(command, portfolio)
}
