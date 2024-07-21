## UI stuff
library(shiny)
library(tidyverse)

## source application files

# global.R reads three separate data files, data.R contains synthetic data for 
# individual businesses, geo_list.RDS contains thirteen provinces and territories, 
# and var_list.RDS contains the three variables that appear in the sinylive app.

source("global.R", local = TRUE)
source("ui.R", local = TRUE)
source("server.R", local = TRUE)

## placeholder language object so that things work for now
lang = "en"

## launch the app!
shinyApp(ui, server)
