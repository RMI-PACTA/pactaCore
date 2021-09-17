FROM rocker/verse:4.0.3
WORKDIR /home/rstudio/pactaCore
COPY inst/extdata/context/DESCRIPTION inst/extdata/context/DESCRIPTION
RUN Rscript -e "remotes::install_deps('inst/extdata/context')"
COPY . .
RUN Rscript -e "devtools::install()"
