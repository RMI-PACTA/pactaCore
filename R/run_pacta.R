#' Run the core steps of the PACTA methodology
#'
#' @param env String. Path to an environment file with pacta variables.
#'
#' @return Called for its side effect. Returns the first argument invisibly.
#' @export
#'
#' @examples
#' if (interactive()) {
#'   local({
#'     # Create a toy, temporary pacta project
#'     pacta <- path_home("pacta_tmp")
#'     local_pacta(pacta)
#'
#'     # Work from the pacta project for convenicenc
#'     local_dir(pacta)
#'
#'     # The ".env" file specifies the setup for input/ output/ and private data
#'     readLines(".env")
#'
#'     # Before
#'     dir_tree()
#'     run_pacta()
#'     # After
#'     dir_tree()
#'   })
#' }
run_pacta <- function(env = ".env") {
  run_pacta_impl(env = env)
  invisible(env)
}

run_pacta_impl <- function(env = ".env",
                           code = expression(run_pacta_legacy(
                             source = ".",
                             input = input,
                             output = output))) {
  abort_if_missing_env(env)
  input <- path_env("PACTA_INPUT", env)
  abort_if_dir_doesnt_exist(input)
  abort_if_missing_inputs(input)
  output <- path_env("PACTA_OUTPUT", env)
  abort_if_not_empty_dir(output_results_path(path_dir(output)))
  data <- path_env("PACTA_DATA", env)

  parent <- path(tempdir(), tempfile())
  setup_source_data(parent, legacy_path(), data)
  local_dir(path(parent, legacy_dirname()))

  dir_destroy(wd_path())
  create_wd(".")

  eval(code)

  invisible(env)
}

#' Run PACTA for all portfolios in an input directory
#'
#' @param source String. Path to PACTA's legacy source code.
#' @param input,output String. Path to directories input/ and output/.
#'
#' @examples
#' run_pacta_legacy(
#'   source = ".",
#'   input = "~/pacta_tmp/input",
#'   output = "~/pacta_tmp/output"
#' )
#' @noRd
run_pacta_legacy <- function(source, input, output) {
  source <- path_abs(source)
  input <- path_abs(input)
  output <- path_abs(output)

  local_dir(source)
  abort_if_pacta_data_isnt_sibling(source)

  setup_input(source, input)

  portfolios <- portfolio_names(input, portfolio_pattern())
  command <- sprintf("Rscript --vanilla pacta_legacy.R %s", portfolios)
  for (i in seq_along(command)) {
    message("Start portfolio: ", portfolios[[i]])
    system(command[[i]])
  }

  setup_output(source, output)
  access <- get_permissions(input)
  walk(c(input, output), apply_permissions, access)

  invisible(source)
}

abort_if_pacta_data_isnt_sibling <- function(source) {
  is_sibling <- dir_exists(path(path_dir(source), "pacta-data"))
  if (!is_sibling) {
    stop("Can't find pacta-data/", call. = FALSE)
  }

  invisible(source)
}

setup_input <- function(source, input) {
  yml <- dir_ls(input, regexp = "[.]yml$")
  file_duplicate(yml, path(source, parameter_file_path(path_file(yml))))

  csv <- dir_ls(input, regexp = "[.]csv$")
  file_duplicate(csv, path(source, raw_inputs_path(path_file(csv))))

  invisible(source)
}

setup_output <- function(wd, output) {
  dir_duplicate(path(wd, wd_path()), path(output, wd_path()))

  files <- dir_ls(output, recurse = TRUE)
  file_chmod(files, "a+rwx")

  invisible(wd)
}

apply_permissions <- function(dir, access) {
  files <- dir_ls(dir, recurse = TRUE)
  file_chown(files, user_id = access[["user"]], group_id = access[["group"]])

  invisible(dir)
}

get_permissions <- function(path) {
  path <- path_expand(path)
  parent <- path_dir(path_abs(path))
  info <- dir_info(parent)

  c(
    user = info[info$path == path, c("user")][[1]],
    group = info[info$path == path, c("group")][[1]]
  )
}

#' @examples
#' get_permissions("/home")
#' get_permissions("~")
#' @noRd
get_permissions <- function(path) {
  path <- path_expand(path)
  parent <- path_dir(path_abs(path))
  info <- dir_info(parent)

  c(
    user = info[info$path == path, c("user")][[1]],
    group = info[info$path == path, c("group")][[1]]
  )
}

portfolio_names <- function(dir, regexp) {
  csv <- dir_ls(dir, regexp = regexp)
  path_ext_remove(path_file(csv))
}
