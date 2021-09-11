
This document guides contributors. It extends
[README](https://github.com/2DegreesInvesting/pactaCore/blob/main/README.md)
focusing on how this R package differs form a standard one.

-   Some environment variables are convenient or required. A good place
    to set them is in a project-specific .Renviron file, e.g.:

<!-- -->

    PACTA_SKIP_SLOW_TESTS=FALSE
    PACTA_DATA=/home/mauro/git/siblings/pacta-data

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

    /home/mauro/git/siblings/pactaCore/tests/testthat/private
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
function `compare()`.
