FROM rocker/r-ubuntu:20.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    sudo \
    pandoc \
    pandoc-citeproc \
    libcurl4-gnutls-dev \
    libcairo2-dev \
    libxt-dev \
    libssl-dev \
    libssh2-1-dev \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/shiny-server/bookmarks/shiny

# Download and install library
RUN R -e "install.packages(c('shinydashboard', 'shinyjs', 'V8'))"

# copy the app to the image
COPY my-shiny-app /root/app

EXPOSE 3838

CMD ["R", "-e", "shiny::runApp('/root/app', host='0.0.0.0', port=3838)"]
