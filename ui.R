library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("EPI View"),
  sidebarPanel(
    textInput("newchrom", "Chromosomes to view (1-22, X,Y):", value = "21,X,Y"),
    helpText("Use a dash to select a range and a comma to seperate values. X and Y cannot be seen on their own. eg. 4-7, 21"),
    br(),
    checkboxInput(inputId = 'heatmap', 'Heatmap', FALSE),
    checkboxInput(inputId = 'scatterplot', 'Scatterplot', FALSE),
    checkboxInput(inputId = 'line', 'Line', FALSE),
    checkboxInput(inputId = 'histogram', 'Histogram', TRUE),
    checkboxInput(inputId = 'tiletrack', 'Tiletrack', FALSE),
    br(),
    fileInput(inputId = 'histonefile', 'Upload suitable histone data file', accept = c('.rda')),
    submitButton("Update View")
  ),
  mainPanel(
    plotOutput('wholegenome','100%','820px')
  )))
