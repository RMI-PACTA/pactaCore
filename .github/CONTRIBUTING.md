
This document guides contributors. It extends
[README](https://github.com/2DegreesInvesting/pactaCore/blob/main/README.md)
focusing on how this R package differs form a standard one.

-   You may run or skip slow tests with an environment variable in
    .Renviron:

<!-- -->

    PACTA_SKIP_SLOW_TESTS=FALSE

-   The repositories PACTA\_analysis/ is required for regression tests.
    Clone it from 2DII’s GitHub organization and keep it up to date with
    the repo on GitHub.

``` bash
"git clone git@github.com:2DegreesInvesting/PACTA_analysis.git"
```

-   Set the path to PACTA\_analysis/ in the .env file, along with the
    other, user-facing environment variables.

<!-- -->

    PACTA_DATA=/home/mauro/pacta-data
    PACTA_ANALYSIS=/home/mauro/PACTA_analysis

-   To work from docker container run `docker-compose up` and point to
    web browser to localhost:8787.

-   In the container, the required directories will be mounted under the
    /home/rstudio, and discovered via the file .env\_rstudio:

<!-- -->

    PACTA_DATA=/home/rstudio/pacta-data
    PACTA_ANALYSIS=/home/rstudio/PACTA_analysis

-   Git ignores all files under the directory tests/testthat/\_snaps/ to
    avoid leaking private data. Re-include public snapshots in
    .gitignore with a negation pattern (!), e.g.:

<!-- -->

    tests/testthat/_snaps/**
    !tests/testthat/_snaps/run_pacta.md
    !tests/testthat/_snaps/run_web_tool.md

-   Git ignores the directory tests/testthat/private/. Use it to store
    regression references or other private data.

<!-- -->

    /home/rstudio/pactaCore/tests/testthat/private
    ├── pacta_core
    │   └── TestPortfolio_Input
    │       ├── Bonds_results_company.rda
    │       ├── Bonds_results_map.rda
    │       ├── Bonds_results_portfolio.rda
    │       ├── Equity_results_company.rda
    │       ├── Equity_results_map.rda
    │       └── Equity_results_portfolio.rda
    └── web_tool
        └── TestPortfolio_Input
            ├── Bonds_results_company.rda
            ├── Bonds_results_map.rda
            ├── Bonds_results_portfolio.rda
            ├── Equity_results_company.rda
            ├── Equity_results_map.rda
            └── Equity_results_portfolio.rda

You may compare two lists of reference datasets with the internal
function `compare_full()`.
