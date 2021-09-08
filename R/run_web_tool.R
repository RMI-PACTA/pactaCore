run_web_tool <- function() {
  abort_if_missing_siblng(path_parent(siblings()))

  docker_run <- sprintf("docker run --rm -v %s:/root --workdir /root/PACTA_analysis 2dii/r-packages", path_parent())
  rscript <- r'(Rscript -e "source('R/source_web_tool_scripts.R'); source_web_tool_scripts()")'
  command <- paste(docker_run, rscript)
  system(command)
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
