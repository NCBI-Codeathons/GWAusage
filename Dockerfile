FROM rocker/shiny-verse:latest

# system libraries of general use
RUN apt-get update && apt-get install -y \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev 


# install R packages required 
# (change it depending on the packages you need)
RUN R -e "install.packages('shinydashboard', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shiny', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('dplyr', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('leaflet', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('dashboardthemes', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('data.table', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('DECIPHER', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('RColorBrewer', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('ggplot2', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('plotly', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinyWidgets', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('shinycssloaders', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('MASS', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('qqman', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('manhattanly', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('haploR', repos='http://cran.rstudio.com/')"


# copy the app to the image
COPY GWAusage.Rproj /srv/shiny-server/
COPY shiny_gwas.R /srv/shiny-server/
COPY result /srv/shiny-server/result
COPY input /srv/shiny-server/input
COPY temp /srv/shiny-server/temp
COPY program /srv/shiny-server/program
COPY www /srv/shiny-server/www

# select port
EXPOSE 3838

# allow permission
RUN sudo chown -R shiny:shiny /srv/shiny-server

#Remove start page
RUN sudo rm /srv/shiny-server/index.html
RUN sudo rm -rf /srv/shiny-server/sample-apps

# run app
CMD ["/usr/bin/shiny-server.sh"]

