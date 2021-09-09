run_web_tool <- function() {
  abort_if_missing_siblng(path_parent(siblings()))
  withr::local_dir(path_parent())
  withr::local_file("entrypoint.R")

  write_r("entrypoint.R", r"(
    source('R/source_web_tool_scripts.R')
    source_web_tool_scripts()
  )")

  command <- sprintf("docker run --rm \\
    -v %s:/home \\
    --workdir /home/PACTA_analysis \\
    2dii/r-packages Rscript /home/entrypoint.R", path_parent())

  system(command)
}

abort_if_missing_siblng <- function(path) {
  sibling_exists <- dir_exists(path)
  if (!all(sibling_exists)) {
    missing <- paste("*", names(sibling_exists[!sibling_exists]), collapse = "\n")
    stop(
      "Each sibling directory must exist but some don't:\n",
      missing,
      call. = FALSE
    )
  }

  invisible(path)
}

write_r <- function(path = tempfile(), r = r"()") {
  writeLines(r, con = path)
  invisible(path)
}

siblings <- function(include_pacta_analysis = FALSE) {
  out <- c(
    "pacta-data",
    "create_interactive_report",
    "r2dii.climate.stress.test",
    "r2dii.stress.test.data"
  )

  if (include_pacta_analysis) {
    out <- append(out, "PACTA_analysis")
  }

  sort(out)
}
