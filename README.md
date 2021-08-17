---
output: github_document
---

<!-- README.md is generated from README.Rmd. Please edit that file -->



# pactaCore <a href='https://github.com/2DegreesInvesting/pactaCore'><img src='https://imgur.com/A5ASZPE.png' align='right' height='43' /></a>

<!-- badges: start -->
[![Lifecycle: experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html)
[![CRAN status](https://www.r-pkg.org/badges/version/pactaCore)](https://CRAN.R-project.org/package=pactaCore)
[![R-CMD-check](https://github.com/2DegreesInvesting/pactaCore/workflows/R-CMD-check/badge.svg)](https://github.com/2DegreesInvesting/pactaCore/actions)
<!-- badges: end -->

The main goal of pactaCore is to run the core steps of the [PACTA
methodology](https://2degrees-investing.org/resource/pacta/). This document
helps you to install, setup, and run PACTA from a terminal (e.g. bash).

### 1. Install

Clone the private data and public source code from GitHub, then work from
your local clone of the source code:

```bash
git clone git@github.com:2DegreesInvesting/pacta-data.git  # Private data!
git clone git@github.com:2DegreesInvesting/pactaCore.git
cd pactaCore
```

### 2. Setup

Setup  directories for inputs and outputs (io):

* Create input/ and output/ directories, as siblings of your working directory.

* Populate the input directory with portfolio files like
[TestPortfolio_Input.csv](https://github.com/2DegreesInvesting/pactaCore/blob/master/working_dir/20_Raw_Inputs/TestPortfolio_Input.csv),
and parameters files like
[TestPortfolio_Input_PortfolioParameters.yml](https://github.com/2DegreesInvesting/pactaCore/blob/master/working_dir/10_Parameter_File/TestPortfolio_Input_PortfolioParameters.yml).

Add an .env file at the root of pactaCore, locating the directories pacta-data/,
input/, and output/ in your computer. This is the interface where you as a user
tell the application where to look for inputs and store outputs.

For example, Mauro's .env file looks like this:


```
PACTA_DATA=/home/mauro/git/pacta-data
PACTA_INPUT=/home/mauro/tmp/pacta/input
PACTA_OUTPUT=/home/mauro/tmp/pacta/output
```

<details> 

Each corresponding `<pair-name>` the portfolio and parameter files must be named
`<pair-name>_Input.csv` and `<pair-name>_Input_PortfolioParameters.yml`,
respectively. For example:

  * This pair is valid: `a_Input.csv`, `a_Input_PortfolioParameters.yml`.
  
  * This pair is invalid: `a_Input.csv`, `b_Input_PortfolioParameters.yml`.

In the parameter files, whatever values you give to `portfolio_name_in` and
`investor_name_in` will populate the columns `portfolio_name` and
`investor_name` of some output files. For example:

* A parameter file:


```
Warning in file(con, "r"): cannot open file 'working_dir/10_Parameter_File/
TestPortfolio_Input_PortfolioParameters.yml': No such file or directory
Error in file(con, "r"): cannot open the connection
```

* A few rows of some relevant output files and columns:


```
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

* The tree of the input/ and output/ directories before running the application
should be similar to this:

```bash
(input)
├── TestPortfolio_Input.csv
└── TestPortfolio_Input_PortfolioParameters.yml

0 directories, 2 files

(output)

0 directories, 0 files
```

</details>

### 3. Run

Run PACTA via [`docker-compose`](https://docs.docker.com/compose/install/).

```bash
docker-compose up
```

<details>

You may interact with the PACTA container with:

```bash
docker-compose run app bash
```

You may mount your local source code with:

```bash
docker-compose run -v "$(pwd)":/pactaCore app bash
```

These are the files used to create the Docker image and run the container:


```bash
cat Dockerfile
FROM rocker/r-ver:latest

RUN Rscript -e 'install.packages("remotes")'

COPY DESCRIPTION /bound/DESCRIPTION
RUN Rscript -e 'remotes::install_deps("/bound", dependencies = TRUE)'

COPY . /bound

CMD ["Rscript","--vanilla","-e","setwd('/bound'); source('R/run_pacta.R'); run_pacta()"]
```


```bash
cat docker-compose.yml
version: "3.2"
services: 
  app:
    build: .
```


```bash
cat docker-compose.override.yml
version: "3.2"
services:
  app:
    working_dir: /bound 
    env_file:
      - .env
    volumes:
      - ${PACTA_DATA}:/pacta-data:ro
      - ${PACTA_INPUT}:/input:ro
      - ${PACTA_OUTPUT}:/output
```

The tree of the input/ and output/ directories after running the application
should be similar to this:

```bash
./bin/tree-io
(input)
├── TestPortfolio_Input.csv
└── TestPortfolio_Input_PortfolioParameters.yml

0 directories, 2 files

(output)
└── working_dir
    ├── 00_Log_Files
    │   └── TestPortfolio_Input
    ├── 10_Parameter_File
    │   └── TestPortfolio_Input_PortfolioParameters.yml
    ├── 20_Raw_Inputs
    │   └── TestPortfolio_Input.csv
    ├── 30_Processed_Inputs
    │   └── TestPortfolio_Input
    │       ├── audit_file.csv
    │       ├── audit_file.rda
    │       ├── bonds_portfolio.rda
    │       ├── coveragegraph.json
    │       ├── coveragegraphlegend.json
    │       ├── coveragetextvar.json
    │       ├── emissions.rda
    │       ├── equity_portfolio.rda
    │       ├── fund_coverage_summary.rda
    │       ├── invalidsecurities.csv
    │       ├── invalidsecurities.json
    │       ├── overview_portfolio.rda
    │       ├── portfolio_weights.json
    │       └── total_portfolio.rda
    ├── 40_Results
    │   └── TestPortfolio_Input
    │       ├── Bonds_results_company.rda
    │       ├── Bonds_results_map.rda
    │       ├── Bonds_results_portfolio.rda
    │       ├── Equity_results_company.rda
    │       ├── Equity_results_map.rda
    │       └── Equity_results_portfolio.rda
    └── 50_Outputs
        └── TestPortfolio_Input

11 directories, 22 files
```

</details>

## Funding

This project has received funding from the [European Union LIFE
program](https://wayback.archive-it.org/12090/20210412123959/https://ec.europa.eu/easme/en/)
and the [International Climate Initiative
(IKI)](https://www.international-climate-initiative.com/en/details/project/measuring-paris-agreement-alignment-and-financial-risk-in-financial-markets-18_I_351-2982).
The Federal Ministry for the Environment, Nature Conservation and Nuclear Safety
(BMU) supports this initiative on the basis of a decision adopted by the German
Bundestag. The views expressed are the sole responsibility of the authors and do
not necessarily reflect the views of the funders. The funders are not
responsible for any use that may be made of the information it contains.
