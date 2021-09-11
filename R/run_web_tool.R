# path: Path to source code, e.g. /path/to/PACTA_analysis
# x: Script(s) number web_tool_script_{1:3}.R
run_web_tool <- function(path = parent_path("PACTA_analysis"), x = 1:3) {
  abort_if_missing_sibling(path_dir(path))
  withr::local_dir(path)

  source_web_tool_scripts <- NULL
  source(path("R", "source_web_tool_scripts.R"))
  source_web_tool_scripts(x)

  invisible(path)
}

abort_if_missing_sibling <- function(parent) {
  exist <- unlist(lapply(path(parent, siblings()), dir_exists))
  if (!all(exist)) {
    stop(
      "Each directory must exist at ", parent, ":\n",
      paste("* ", siblings(), collapse = "\n"),
      call. = FALSE
    )
  }

  invisible(parent)
}

siblings <- function() {
  c(
    "create_interactive_report",
    "PACTA_analysis",
    "pacta-data",
    "pactaCore",
    "r2dii.climate.stress.test",
    "r2dii.stress.test.data"
  )
}
