
<!-- README.md is generated from README.Rmd. Please edit that file -->

# pactaCore

    <!-- badges: start -->
    [![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
    [![R-CMD-check](https://github.com/2DegreesInvesting/pactaCore/workflows/R-CMD-check/badge.svg)](https://github.com/2DegreesInvesting/pactaCore/actions)
    <!-- badges: end -->

The goal of pactaCore is run the core steps of the [PACTA
methodology](https://2degrees-investing.org/resource/pacta/) with a
single command, in a reproducible way.

## Installation

You can install the development version from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("2DegreesInvesting/pactaCore")
```

## Using PACTA to get results for one or more portfolios

As usual, use pactaCore with `library()`. Here we also use other
optional but convenient packages.

``` r
library(pactaCore)
library(fs)
```

### Setup

`create_pacta()` sets up a pacta project with a fake portfolio and
parameter file. For a real analysys you should replace the test
portfolio and parameter files with your own, and work not in a temporary
directory but in a persistent one.

``` r
pacta <- create_pacta(dir = tempfile("pacta"), data = "~/pacta-data")

dir_tree(pacta, all = TRUE)
#> /tmp/Rtmpg0BQ5a/pacta908b1a7a25a3
#> ├── .env
#> ├── input
#> │   ├── TestPortfolio_Input.csv
#> │   └── TestPortfolio_Input_PortfolioParameters.yml
#> └── output
```

-   The .env file locates the input/, output/, and pacta-data/
    directories.

``` r
env <- path(pacta, ".env")
readLines(env)
#> [1] "PACTA_OUTPUT=/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output"
#> [2] "PACTA_INPUT=/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/input"  
#> [3] "PACTA_DATA=~/pacta-data"
```

-   The input/ directory must contain portfolio files like
    [TestPortfolio\_Input.csv](https://github.com/2DegreesInvesting/pactaCore/blob/master/inst/extdata/TestPortfolio_Input.csv),
    and parameters files like
    [TestPortfolio\_Input\_PortfolioParameters.yml](https://github.com/2DegreesInvesting/pactaCore/blob/master/inst/extdata/TestPortfolio_Input_PortfolioParameters.yml).

-   The output/ directory typically starts empty.

-   The pacta-data/ directory is private. With permission get if from
    GitHub with:

``` bash
# From the terminal
git clone git@github.com:2DegreesInvesting/pacta-data.git
```

### Run PACTA

`run_pacta()` runs PACTA on the project described by your .env file.

``` r
run_pacta(env)
#> Start portfolio: TestPortfolio_Input
```

The output/ directory is now populated with results:

``` r
dir_tree(path(pacta, "output"))
#> /tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output
#> └── working_dir
#>     ├── 00_Log_Files
#>     │   └── TestPortfolio_Input
#>     ├── 10_Parameter_File
#>     │   └── TestPortfolio_Input_PortfolioParameters.yml
#>     ├── 20_Raw_Inputs
#>     │   └── TestPortfolio_Input.csv
#>     ├── 30_Processed_Inputs
#>     │   └── TestPortfolio_Input
#>     │       ├── audit_file.csv
#>     │       ├── audit_file.rda
#>     │       ├── bonds_portfolio.rda
#>     │       ├── coveragegraph.json
#>     │       ├── coveragegraphlegend.json
#>     │       ├── coveragetextvar.json
#>     │       ├── emissions.rda
#>     │       ├── equity_portfolio.rda
#>     │       ├── fund_coverage_summary.rda
#>     │       ├── invalidsecurities.csv
#>     │       ├── invalidsecurities.json
#>     │       ├── overview_portfolio.rda
#>     │       ├── portfolio_weights.json
#>     │       └── total_portfolio.rda
#>     ├── 40_Results
#>     │   └── TestPortfolio_Input
#>     │       ├── Bonds_results_company.rda
#>     │       ├── Bonds_results_map.rda
#>     │       ├── Bonds_results_portfolio.rda
#>     │       ├── Equity_results_company.rda
#>     │       ├── Equity_results_map.rda
#>     │       └── Equity_results_portfolio.rda
#>     └── 50_Outputs
#>         └── TestPortfolio_Input
```

<details>

For each corresponding `<pair-name>`, the portfolio and parameter files
must be named `<pair-name>_Input.csv` and
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
writeLines(readLines(example_input_paths()[[2]]))
#> default:
#>     parameters:
#>         portfolio_name_in: TestPortfolio_Input
#>         investor_name_in: Test
#>         peer_group: pensionfund
#>         language: EN
#>         project_code: GENERAL
```

-   A few rows of some relevant output files and columns:

<!-- -->

    #> $`/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output/working_dir/40_Results/TestPortfolio_Input/Bonds_results_company.rda`
    #> # A tibble: 6 × 2
    #>   portfolio_name      investor_name
    #>   <chr>               <chr>        
    #> 1 TestPortfolio_Input Test         
    #> 2 TestPortfolio_Input Test         
    #> 3 TestPortfolio_Input Test         
    #> 4 TestPortfolio_Input Test         
    #> 5 TestPortfolio_Input Test         
    #> 6 TestPortfolio_Input Test         
    #> 
    #> $`/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output/working_dir/40_Results/TestPortfolio_Input/Bonds_results_map.rda`
    #> # A tibble: 6 × 2
    #>   portfolio_name      investor_name
    #>   <chr>               <chr>        
    #> 1 TestPortfolio_Input Test         
    #> 2 TestPortfolio_Input Test         
    #> 3 TestPortfolio_Input Test         
    #> 4 TestPortfolio_Input Test         
    #> 5 TestPortfolio_Input Test         
    #> 6 TestPortfolio_Input Test         
    #> 
    #> $`/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output/working_dir/40_Results/TestPortfolio_Input/Bonds_results_portfolio.rda`
    #> # A tibble: 6 × 2
    #>   portfolio_name      investor_name
    #>   <chr>               <chr>        
    #> 1 TestPortfolio_Input Test         
    #> 2 TestPortfolio_Input Test         
    #> 3 TestPortfolio_Input Test         
    #> 4 TestPortfolio_Input Test         
    #> 5 TestPortfolio_Input Test         
    #> 6 TestPortfolio_Input Test         
    #> 
    #> $`/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output/working_dir/40_Results/TestPortfolio_Input/Equity_results_company.rda`
    #> # A tibble: 6 × 2
    #>   portfolio_name      investor_name
    #>   <chr>               <chr>        
    #> 1 TestPortfolio_Input Test         
    #> 2 TestPortfolio_Input Test         
    #> 3 TestPortfolio_Input Test         
    #> 4 TestPortfolio_Input Test         
    #> 5 TestPortfolio_Input Test         
    #> 6 TestPortfolio_Input Test         
    #> 
    #> $`/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output/working_dir/40_Results/TestPortfolio_Input/Equity_results_map.rda`
    #> # A tibble: 6 × 2
    #>   portfolio_name      investor_name
    #>   <chr>               <chr>        
    #> 1 TestPortfolio_Input Test         
    #> 2 TestPortfolio_Input Test         
    #> 3 TestPortfolio_Input Test         
    #> 4 TestPortfolio_Input Test         
    #> 5 TestPortfolio_Input Test         
    #> 6 TestPortfolio_Input Test         
    #> 
    #> $`/tmp/Rtmpg0BQ5a/pacta908b1a7a25a3/output/working_dir/40_Results/TestPortfolio_Input/Equity_results_portfolio.rda`
    #> # A tibble: 6 × 2
    #>   portfolio_name      investor_name
    #>   <chr>               <chr>        
    #> 1 TestPortfolio_Input Test         
    #> 2 TestPortfolio_Input Test         
    #> 3 TestPortfolio_Input Test         
    #> 4 TestPortfolio_Input Test         
    #> 5 TestPortfolio_Input Test         
    #> 6 TestPortfolio_Input Test

</details>
