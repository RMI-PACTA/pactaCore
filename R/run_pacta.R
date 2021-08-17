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
#' run_pacta()
#' @noRd
run_pacta <- function(source = here::here(),
                      input = "../input",
                      output = "../output") {
  withr::local_dir(source)

  setup_input(source, input)

  portfolios <- portfolios(path = input)
  command <- glue::glue("Rscript --vanilla pacta_core.R {portfolios}")
  for (i in seq_along(command)) {
    message("Start portfolio: ", portfolios[[i]])
    system(command[[i]])
    message("End portfolio: ", portfolios[[i]])
  }

  setup_output(source, output)
}

setup_input <- function(source, input) {
  # FIXME: Should we also support ".yaml" (with an "a")?
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

  invisible(wd)
}

# Get the name of the portfolios, assuming /input is a sibling of /bound inside
# a docker container from the image created by Dockerfile in this repo
portfolios <- function(path = "../input", regexp = "_Input[.]csv") {
  csv <- fs::dir_ls(path, regexp = regexp)
  fs::path_ext_remove(fs::path_file(csv))
}
