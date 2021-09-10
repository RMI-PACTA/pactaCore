run_web_tool <- function(pacta_analysis = parent_path("PACTA_analysis"),
                         x = 1:3) {
  parent <- path_dir(pacta_analysis)
  abort_if_missing_sibling(parent)

  withr::local_dir(pacta_analysis)
  source(path("R", "source_web_tool_scripts.R"))
  source_web_tool_scripts(x)
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
