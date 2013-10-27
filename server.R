# Load packages
library(shiny)
library(RCircos)
source("./epiview.R")

# Shiny Server
shinyServer(function(input, output) {
  output$wholegenome <- renderPlot({
    RCircos.Demo.Human(input, output)
    
  })
})