library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("EPI View"),
  sidebarPanel(
    textInput("newchrom", "Chromosomes to view (1-22, X,Y):", value = "X,Y"),
    helpText("Use a dash to select a range and a comma to seperate values. No Spaces! and Y cannot be seen on its own. eg. 4-7, 21, X"),
    br(),
    checkboxInput(inputId = 'heatmap', 'Heatmap', FALSE),
    checkboxInput(inputId = 'scatterplot', 'Scatterplot', FALSE),
    checkboxInput(inputId = 'line', 'Line', FALSE),
    checkboxInput(inputId = 'histogram', 'Histogram', TRUE),
    checkboxInput(inputId = 'tiletrack', 'Tiletrack', FALSE),
    br(),
    submitButton("Update View")
  ),
  mainPanel(
    plotOutput('wholegenome','100%','820px')
  )))