library(shiny)

ui <- fluidPage(
  h1('Esse é o nosso shiny app', align = 'center'),
  hr(),
  h3('Sobre este app', style = 'color: #a40f0d'),
  p("Lorem ipsum",  strong('dolor sit amet', .noWS = 'after'), ", consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."),
  hr(),
  fluidRow(
    column(
      offset = 5,
      width = 2,
      fluidRow(
        column(
          offset = 3,
          width = 6,
            img(
              src = 'zen-do-r.png',
              width = '100%'
              # style = 'display: block; margin: auto'
            )
        )
      )
    )
  )

)

server <- function(input, output, session) {
  
}

shinyApp(ui, server)