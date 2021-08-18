
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pactaCore

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

The goal of pactaCore is to to help you run the core of [PACTA
methodology](https://2degrees-investing.org/resource/pacta/)
reproducibly and with a single command.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("2DegreesInvesting/pactaCore")
```

## Example

``` r
library(pactaCore)
```

-   `pacta_core_with_env()` takes paths to output/, input/ and
    pacta-data/ directories (see Setup below). It defaults paths under
    your working directory:

``` r
withr::local_dir("../pacta")
fs::dir_ls(regexp = "output|input|pacta-data")
#> input      output     pacta-data
```

``` r
pacta_core_with_env()
```

-   `pacta_core_with_env_with_env()` takes a paths to an environment
    file defining the paths to the output/, input/ and pacta-data/
    directories. It defaults a file called “.env” under your working
    directory:

``` r
withr::local_dir("../pacta")
readLines(".env")
#> [1] "PACTA_DATA=/home/mauro/git/pacta/pacta-data"
#> [2] "PACTA_INPUT=/home/mauro/git/pacta/input"    
#> [3] "PACTA_OUTPUT=/home/mauro/git/pacta/output"
```

``` r
pacta_core_with_env_with_env()
```

Both functions produce the same output.

## Setup

-   The output/ directory can be empty.

-   The input/ directory must contain portfolio files like
    [TestPortfolio\_Input.csv](https://github.com/2DegreesInvesting/pactaCore/blob/master/working_dir/20_Raw_Inputs/TestPortfolio_Input.csv),
    and parameters files like
    [TestPortfolio\_Input\_PortfolioParameters.yml](https://github.com/2DegreesInvesting/pactaCore/blob/master/working_dir/10_Parameter_File/TestPortfolio_Input_PortfolioParameters.yml).

-   The pacta-data/ directory can be cloned from its private GitHub
    repository.

``` bash
git clone git@github.com:2DegreesInvesting/pacta-data.git  # Private data!
```

<details>

Each corresponding `<pair-name>` the portfolio and parameter files must
be named `<pair-name>_Input.csv` and
`<pair-name>_Input_PortfolioParameters.yml`, respectively. For example:

-   This pair is valid: `a_Input.csv`,
    `a_Input_PortfolioParameters.yml`.

-   This pair is invalid: `a_Input.csv`,
    `b_Input_PortfolioParameters.yml`.

In the parameter files, whatever values you give to `portfolio_name_in`
and `investor_name_in` will populate the columns `portfolio_name` and
`investor_name` of some output files. For example:

-   A parameter file:

``` r
default:
    parameters:
        portfolio_name_in: TestPortfolio_Input
        investor_name_in: Test
        peer_group: pensionfund
        language: EN
        project_code: CHPA2020
```

-   A few rows of some relevant output files and columns:

``` r
$Bonds_results_company.rda
       portfolio_name investor_name
1 TestPortfolio_Input          Test
2 TestPortfolio_Input          Test
3 TestPortfolio_Input          Test

$Bonds_results_map.rda
       portfolio_name investor_name
1 TestPortfolio_Input          Test
2 TestPortfolio_Input          Test
3 TestPortfolio_Input          Test

$Bonds_results_portfolio.rda
       portfolio_name investor_name
1 TestPortfolio_Input          Test
2 TestPortfolio_Input          Test
3 TestPortfolio_Input          Test
```

-   The tree of the input/ directory:

``` bash
(input)
├── TestPortfolio_Input.csv
└── TestPortfolio_Input_PortfolioParameters.yml

0 directories, 2 files
```

-   The tree of the output/ directory before `pacta_core_with_env()`:

``` bash
(output)

0 directories, 0 files
```

-   The tree of the output/ directory after `pacta_core_with_env()`:

``` bash
output
└── working_dir
    ├── 00_Log_Files
    │   └── TestPortfolio_Input
    ├── 10_Parameter_File
    │   └── TestPortfolio_Input_PortfolioParameters.yml
    ├── 20_Raw_Inputs
    │   └── TestPortfolio_Input.csv
    ├── 30_Processed_Inputs
    │   └── TestPortfolio_Input
    │       ├── audit_file.csv
    │       ├── audit_file.rda
    │       ├── bonds_portfolio.rda
    │       ├── coveragegraph.json
    │       ├── coveragegraphlegend.json
    │       ├── coveragetextvar.json
    │       ├── emissions.rda
    │       ├── equity_portfolio.rda
    │       ├── fund_coverage_summary.rda
    │       ├── invalidsecurities.csv
    │       ├── invalidsecurities.json
    │       ├── overview_portfolio.rda
    │       ├── portfolio_weights.json
    │       └── total_portfolio.rda
    ├── 40_Results
    │   └── TestPortfolio_Input
    │       ├── Bonds_results_company.rda
    │       ├── Bonds_results_map.rda
    │       ├── Bonds_results_portfolio.rda
    │       ├── Equity_results_company.rda
    │       ├── Equity_results_map.rda
    │       └── Equity_results_portfolio.rda
    └── 50_Outputs
        └── TestPortfolio_Input
```

</details>
