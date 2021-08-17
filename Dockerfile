FROM rocker/r-ver:latest

RUN Rscript -e 'install.packages("remotes")'

COPY DESCRIPTION /bound/DESCRIPTION
RUN Rscript -e 'remotes::install_deps("/bound", dependencies = TRUE)'

COPY . /bound

CMD ["Rscript","--vanilla","-e","source('/bound/R/run_pacta.R'); run_pacta()"]
