#' A vectorized version of `waldo::compare()`
#'
#' Defaults to comparing private results between the web tool and this package.
#'
#' @param new,old A list of dataframes.
#' @param ... Passed to `waldos::compare()`
#'
#' @return Called for its side effect. Prints differences.
#'
#' @family developer oriented
#' @export
#'
#' @examples
#' \dontrun{
#'   new <- list(x = data.frame(a = 1, b = 1), x = data.frame(a = 1, b = 9))
#'   old <- list(x = data.frame(a = 1, b = 1), x = data.frame(a = 1, b = 1))
#'   compare_full(new, old)
#'   compare_full(new, new)
#' }
compare_full <- function(new = enlist_rds(private_path("pacta_core")),
                         old = enlist_rds(private_path("web_tool")),
                         ...) {
  for (i in seq_along(old)) {
    print(paste(names(new)[[i]], "(new)", "vs.", names(old)[[i]], "(old)"))
    try(
      print(waldo::compare(old[[i]], new[[i]], ...))
    )
  }

  invisible(new)
}
