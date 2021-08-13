#' Run PACTA for all portfolios matching a pattern in an input directory
#'
#' @param wd String. Working directory pointing to pacta's source code
#' @param regext String. Regular expression that defines a valid portfolio name.
#'
#' @examples
#' run_pacta()
#' @noRd
run_pacta <- function(source = pacta_envvar("SOURCE", unset = here::here()),
                      input = pacta_envvar("INPUT", unset = "../input"),
                      output = pacta_envvar("OUTPUT", unset = "../output")) {
  withr::local_dir(source)

  setup_input(wd = source, input = input)

  portfolios <- portfolios(path = input)
  command <- glue::glue("Rscript --vanilla pacta_core.R {portfolios}")
  for (i in seq_along(command)) {
    message("Start portfolio: ", portfolios[[i]])
    system(command[[i]])
    message("End portfolio: ", portfolios[[i]])
  }

  setup_output(source, output)
}

#' Help get environmental variables
#' @examples
#' pacta_envvar("SOURCE")
#' pacta_envvar("SOURCE", unset = here::here())
#' withr::with_envvar(new = c(PACTA_SOURCE = "/home"), pacta_envvar("SOURCE"))
#' @noRd
pacta_envvar <- function(suffix, unset = "") {
  Sys.getenv(glue::glue("PACTA_{suffix}"), unset = unset)
}


setup_input <- function(wd, input) {
  # FIXME: Should we also support ".yaml" (with an "a")?
  yml <- fs::dir_ls(input, regexp = "[.]yml$")
  fs::file_copy(
    yml,
    fs::path(wd, "working_dir", "10_Parameter_File", fs::path_file(yml)),
    overwrite = TRUE
  )
  csv <- fs::dir_ls(input, regexp = "[.]csv$")
  fs::file_copy(
    csv,
    fs::path(wd, "working_dir", "20_Raw_Inputs", fs::path_file(csv)),
    overwrite = TRUE
  )

  invisible(wd)
}

setup_output <- function(wd, output) {
  fs::dir_copy(
    fs::path(wd, "working_dir"), fs::path(output, "working_dir"),
    overwrite = TRUE
  )

  invisible(wd)
}

#' Get the name of the portfolios
portfolios <- function(path = "../input", regexp = "_Input[.]csv") {
  csv <- fs::dir_ls(path, regexp = regexp)
  fs::path_ext_remove(fs::path_file(csv))
}
