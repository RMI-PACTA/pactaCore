FROM rocker/r-ver:latest

RUN Rscript -e 'install.packages("remotes")'

COPY DESCRIPTION /bound/DESCRIPTION
RUN Rscript -e 'remotes::install_deps("/bound", dependencies = TRUE)'

COPY . /bound

CMD ["Rscript","--vanilla","-e","setwd('/bound'); source('R/run_pacta.R'); run_pacta()"]
