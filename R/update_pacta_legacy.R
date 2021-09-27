#' Update inst/extdata/context/pacta_legacy.R with scripts from PACTA_analysis
#'
#' @return Called for its side effect of writting a file. Returns the first
#'   argument invisibly.
#' @export
#'
#' @family developer oriented
#'
#' @examples
#' \dontrun{
#'   # Online
#'   update_pacta_legacy()
#'
#'   # Local
#'   scripts <- path("~", "PACTA_analysis", paste0("web_tool_script_", 1:2, ".R"))
#'   update_pacta_legacy(scripts)
#' }
update_pacta_legacy <- function(scripts = NULL) {
  scripts <- scripts %||% paste0(
    "https://raw.githubusercontent.com/2DegreesInvesting/PACTA_analysis/master/",
    "web_tool_script_", 1:2, ".R"
  )

  file <- legacy_path("pacta_legacy.R")
  code <- unlist(lapply(scripts, readLines))
  writeLines(code, file)

  invisible(file)
}
