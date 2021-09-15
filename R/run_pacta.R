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
  # TODO: Change the API? Remove .env and add input, output, data?
  input <- path_env("PACTA_INPUT", env)
  abort_if_missing_inputs(input)
  output <- path_env("PACTA_OUTPUT", env)
  abort_if_not_empty_dir(results_path(path_dir(output)))
  data <- path_env("PACTA_DATA", env)

  dir_copy(context_path(), parent_path())
  defer(dir_delete(parent_path("context")))
  local_dir(parent_path("context"))
  create_working_dir(".")

  run_pacta_legacy(source = ".", input = input, output = output)

  invisible(env)
}

#' Run PACTA for all portfolios in an input directory
#'
#' @param source String. Path to pacta's source code
#' @param input,output String. Path to directories input/ and output/ inside the
#'   docker container
#'
#' @examples
#' run_pacta_legacy(
#'   source = ".",
#'   input = "~/pacta_tmp/input",
#'   output = "~/pacta_tmp/output"
#' )
#' @noRd
run_pacta_legacy <- function(source, input, output) {
  source <- fs::path_abs(source)
  input <- fs::path_abs(input)
  output <- fs::path_abs(output)

  local_dir(source)

  # Pretend we're in transition monitor
  in_transitionmonitor <- function() TRUE

  setup_input(source, input)
  portfolios <- portfolio_names(input, regexp = "_Input[.]csv")
  command <- sprintf("Rscript --vanilla pacta_legacy.R %s", portfolios)
  for (i in seq_along(command)) {
    message("Start portfolio: ", portfolios[[i]])
    system(command[[i]])
    message("End portfolio: ", portfolios[[i]])
  }

  setup_output(source, output)

  access <- get_permissions(input)
  walk(c(input, output), apply_permissions, access)

  invisible(source)
}

setup_input <- function(source, input) {
  # TODO: Should we also support ".yaml" (with an "a")?
  yml <- fs::dir_ls(input, regexp = "[.]yml$")
  fs::file_copy(
    yml,
    fs::path(source, "working_dir", "10_Parameter_File", fs::path_file(yml)),
    overwrite = TRUE
  )
  csv <- fs::dir_ls(input, regexp = "[.]csv$")
  fs::file_copy(
    csv,
    fs::path(source, "working_dir", "20_Raw_Inputs", fs::path_file(csv)),
    overwrite = TRUE
  )

  invisible(source)
}

setup_output <- function(wd, output) {
  fs::dir_copy(
    fs::path(wd, "working_dir"), fs::path(output, "working_dir"),
    overwrite = TRUE
  )

  files <- fs::dir_ls(output, recurse = TRUE)
  fs::file_chmod(files, "a+rwx")

  invisible(wd)
}

apply_permissions <- function(dir, access) {
  files <- fs::dir_ls(dir, recurse = TRUE)
  fs::file_chown(files, user_id = access[["user"]], group_id = access[["group"]])

  invisible(dir)
}

get_permissions <- function(path) {
  path <- fs::path_expand(path)
  parent <- fs::path_dir(fs::path_abs(path))
  info <- fs::dir_info(parent)

  c(
    user = info[info$path == path, c("user")][[1]],
    group = info[info$path == path, c("group")][[1]]
  )
}

#' @examples
#' get_permissions("/home")
#' get_permissions("~")
get_permissions <- function(path) {
  path <- fs::path_expand(path)
  parent <- fs::path_dir(fs::path_abs(path))
  info <- fs::dir_info(parent)

  c(
    user = info[info$path == path, c("user")][[1]],
    group = info[info$path == path, c("group")][[1]]
  )
}

portfolio_names <- function(dir, regexp) {
  csv <- fs::dir_ls(dir, regexp = regexp)
  fs::path_ext_remove(fs::path_file(csv))
}
