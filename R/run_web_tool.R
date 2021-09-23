#' Run the web_tool for regression tests
#'
#' @param results String. Path where to save the results.
#' @param source String. Path to the PACTA_analysis repo locally.
#' @param data String. Path to the
#' @param x Number. Vector giving the web tool script to run, e.g. `1` or `1:3`.
#'
#' @return Called for its side effect. Returns the first argument invisibly.
#' @export
#'
#' @family developer oriented
#'
#' @examples
#' \donttest{
#'   run_web_tool()
#' }
run_web_tool <- function(results = path_temp(wd_path()),
                         source = get_env("PACTA_ANALYSIS"),
                         data = get_env("PACTA_DATA"),
                         x = 1:3) {
  abort_if_dir_doesnt_exist(source)
  abort_if_dir_doesnt_exist(data)
  stopifnot(!is_empty_dir(source), !is_empty_dir(data))

  parent <- path_dir(results)
  setup_source_data(parent, source, data)
  local_dir(path(parent, "PACTA_analysis"))

  dir_destroy(wd_path())
  setup_wd(".")

  walk(web_tool_command()[x], function(x) stop_on_error(system(x)))
  dir_move(results_path(), results)

  invisible(results)
}

#' Path based on working_dir, to hide this low level implementation detail
#'
#' This function avoids littering the code base with specific paths we want to
#' move away from.
#'
#' @inheritDotParams fs::path
#'
#' @return String. A path.
#' @export
#'
#' @examples
#' wd_path()
wd_path <- function(...) {
  path("working_dir", ...)
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
