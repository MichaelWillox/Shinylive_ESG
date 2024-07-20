# This file is saved in the directory for the local repo.
# The app.R is saved in ESG
# Shinylive creates files in doc

# Load libraries
library(shinylive)
library(httpuv)

## Convert the shiny app into the assets for running the app in a browser

shinylive::export("ESG", "docs")

## Run the following in an R session to serve the app:
httpuv::runStaticServer("docs", port=7446)
