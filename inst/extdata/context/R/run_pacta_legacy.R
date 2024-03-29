#' Run PACTA for all portfolios matching a pattern in an input directory
#'
#' This function is designed to work inside the docker container created by
#' Dockerfile in this repo.
#'
#' @param source String. Path to pacta's source code
#' @param input,output String. Path to directories input/ and output/ inside the
#'   docker container
#'
#' @examples
#' run_pacta_legacy()
#' @noRd
run_pacta_legacy <- function(source = ".", input = "../input", output = "../output") {
  source <- fs::path_abs(source)
  input <- fs::path_abs(input)
  output <- fs::path_abs(output)

  withr::local_dir(source)

  setup_input(source, input)
  portfolios <- portfolio_names(input, regexp = "_Input[.]csv")
  command <- glue::glue("Rscript --vanilla pacta_legacy.R {portfolios}")
  for (i in seq_along(command)) {
    message("Start portfolio: ", portfolios[[i]])
    system(command[[i]])
    message("End portfolio: ", portfolios[[i]])
  }

  setup_output(source, output)

  access <- get_permissions(input)
  purrr::walk(c(input, output), apply_permissions, access)

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
