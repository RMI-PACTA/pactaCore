#' Run the web_tool
#' @param results Path to where to output results.
#' @param source Path to source code.
#' @param data Path to private pacta-data.
#' @param x Script(s) number web_tool_script_{1:3}.R
#' @noRd
run_web_tool <- function(results = path_temp(wd_path()),
                         source = parent_path("PACTA_analysis"),
                         data = parent_path("pacta-data"),
                         x = 1:3) {
  stopifnot(dir_exists(source), dir_exists(data))

  parent <- path_dir(results)
  setup_source_data(parent, source, data)
  local_dir(path(parent, "PACTA_analysis"))

  dir_destroy(wd_path())
  setup_wd(".")

  walk(web_tool_command()[x], function(x) stop_on_error(system(x)))
  dir_move(results_path(), results)

  invisible(results)
}

setup_source_data <- function(path = tempdir(), source, data) {
  dir_destroy(path)
  dir_create(path)

  dir_copy(source, path)
  dir_copy(data, path)

  invisible(path)
}

setup_wd <- function(path = ".") {
  create_wd(path)

  yml <- dir_ls(extdata_path(), regexp = "[.]yml")
  file_copy(yml, parameter_file_path())

  csv <- dir_ls(extdata_path(), regexp = "[.]csv")
  file_copy(csv, raw_inputs_path())

  invisible(path)
}

# From PACTA_analysis/bin/run-r-scripts
web_tool_command <- function(portfolio = example_input_name()) {
  command <- c(
    "Rscript --vanilla web_tool_script_1.R",
    "Rscript --vanilla web_tool_script_2.R",
    "Rscript --no-save --no-restore --no-site-file --no-environ web_tool_script_3.R"
  )

  paste(command, portfolio)
}
