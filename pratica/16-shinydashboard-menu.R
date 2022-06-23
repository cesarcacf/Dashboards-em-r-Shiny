library(shiny)
library(shinydashboard)

ui <- dashboardPage(
  dashboardHeader(),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Página 1', tabName = 'pag1', icon = icon('file-upload')),
      menuItem('Página 2', tabName = 'pag2', icon = icon('chart-pie')),
      menuItem(
        'Várias páginas',
        icon = icon('angry'),
        menuSubItem(
          'Página 3',
          tabName = 'pag3',
          icon = icon('at')
        ),
        menuSubItem(
          'Página 4',
          tabName = 'pag4'
        )
      )
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = 'pag1',
        h2('Conteúdo da página 1'),
        hr(style = 'border: 1 px solid black'),
        fluidRow(
          column(
            width = 4,
            selectInput(
              'variavel',
              label = 'Selecione uma variável',
              choices = names(mtcars)
            )
          ),
          column(
             width = 8,
             plotOutput('grafico')
          )
        )
      ),
      tabItem(
        tabName = 'pag2',
        h2('Conteúdo da página 2'),
        hr(style = 'border: 1 px solid black')
      ),
      tabItem(
        tabName = 'pag3',
        h2('Conteúdo da página 3'),
        hr(style = 'border: 1 px solid black')
      ),
      tabItem(
        tabName = 'pag4',
        h2('Conteúdo da página 4'),
        hr(style = 'border: 1 px solid black')
      )
    ),
  )
)

server <- function(input, output, session) {
  
  output$grafico <- renderPlot({
    hist(mtcars[[input$variavel]])
  })
  
}

shinyApp(ui, server)