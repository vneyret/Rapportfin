library(shiny)

source('uipersoM.R', local = TRUE)
source('serverpersoM.R')

shinyApp(
  ui = ui,
  server = server
)
