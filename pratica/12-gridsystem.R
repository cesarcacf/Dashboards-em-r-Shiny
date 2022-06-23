quadrado <- function(text = "") {
  div(
    style = "background: darkred; height: 100px; text-align: center; color: white; font-size: 24px;", 
    text
  )
}


library(shiny)

ui <- fluidPage(
  fluidRow(
    column(
      width = 4,
      quadrado('4')
    ),
    column(
      width = 4,
      quadrado('4')
    ),
    column(
      width = 4,
      quadrado('4')
    )
  ),
  br(),
  fluidRow(
    column(
      width = 12,
      quadrado(12)
    ),
    column(
      width = 3,
      offset = 5,
      quadrado(3)
    ),
    column(
      width = 3,
      offset = 1,
      quadrado(2)
    ),
    br(),
    fluidRow(
      column(
        width = 6,
        quadrado(6)
      )
    )  
  )
)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)