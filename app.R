#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#
if (!require("pacman")) install.packages("pacman")
library(pacman)
p_load(
  shiny,
  data.table,
  DT,
  markdown,
  magrittr)

source("ui.R")
source("server.R")

# Run the application 
shinyApp(ui = ui, server = server)

