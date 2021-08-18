run_pacta_core <- function() {
  withr::local_dir("inst/extdata/context")
  system("docker-compose up")
}
