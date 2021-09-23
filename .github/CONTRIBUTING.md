Contributing to pactaCore
================

This document guides contributors. It extends
[README](https://github.com/2DegreesInvesting/pactaCore/blob/main/README.md)
focusing on how this R package differs form a standard one.

## Environment variables

Compared to users, developers must set two additional environment
variables in the .env file:

-   `PACTA_ANALYSIS` sets the path where you cloned the PACTA\_analysis/
    repository. This is used for regression Tests (see [Tests and
    Git](#tests-and-git)).

-   `PASSWORD` sets the password to login to a local RStudio server
    running inside a Docker container on your host computer (see
    [Docker](#docker)).

<!-- -->

    PACTA_DATA=~/pacta-data
    PACTA_ANALYSIS=~/PACTA_analysis

## Docker

You can access a dockerized computing environment in four steps:

1.  Install `docker`.
2.  Install `docker-compose`.
3.  Clone pactaCore and make it your working directory.
4.  Run `docker-compose up`.

Rstudio is now available from your web browser at localhost:8787. Login
with username “rstudio” and your password (see [Environment
variables](#environment-variables)).

In the container, the required directories will be mounted under
/home/rstudio, and discovered via the file .env\_rstudio:

    PACTA_DATA=~/pacta-data
    PACTA_ANALYSIS=~/PACTA_analysis

## Tests and Git

You may run or skip slow tests with an environment variable in
.Renviron:

    PACTA_SKIP_SLOW_TESTS=FALSE
    PACTA_DATA=~/pacta-data

The repository PACTA\_analysis/ is required for regression tests. Clone
it from 2DII’s GitHub organization and keep it up to date with the repo
on GitHub.

``` bash
git clone git@github.com:2DegreesInvesting/PACTA_analysis.git
```

Git ignores all files under the directory tests/testthat/\_snaps/ to
avoid leaking private data. Re-include public snapshots in .gitignore
with a negation pattern (!), e.g.:

    tests/testthat/_snaps/**
    !tests/testthat/_snaps/run_pacta.md
    !tests/testthat/_snaps/run_web_tool.md

Git ignores the directory tests/testthat/private/. Use it to store
regression references or other private data.

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
function `compare_full()`.
