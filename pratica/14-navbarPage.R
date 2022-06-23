library(shiny)

ui <- navbarPage(
  title = 'App com NavbarPage',
  theme = bslib::bs_theme(
    version = 5,
    bootswatch = "darkly"
    # bg = '#3c3936',
    # fg = '#FFFFFF',
    # primary = "#20aad3",
    # secondary = "#20aad3",
    # base_font = bslib::font_google('Prompt'),
    # code_font = bslib::font_google('JetBrains Mono')
  ),
  # theme = shinythemes::shintheme(theme = 'darkly'),
  tabPanel(
    title = 'Tela 1',
    h2('Tela 1'),
    hr(),
    fluidRow(
      column(
        width = 6,
        plotOutput('grafico_1')
      ),
      column(
        width = 6,
        plotOutput('grafico_2')
      )
    )
  ),
  tabPanel(
    title = 'Tela 2',
    h2('Tela 2'),
    hr(),
    sidebarLayout(
      sidebarPanel = sidebarPanel(
        selectInput(
          inputId = 'variavel_1',
          label = 'Selecione uma variável',
          choices = names(mtcars)
        ),
        selectInput(
          inputId = 'variavel_2',
          label = 'Selecione uma variável',
          choices = names(mtcars),
          selected = 'cyl'
        )
      ),
      mainPanel = mainPanel(
        plotOutput('grafico_3')
      )
    )
  ),
  navbarMenu(
    title = 'Várias telas',
    tabPanel(
      title = 'Tela 3',
      h2('Tela 3')
    ),
    tabPanel(
      title = 'Tela 4',
      h2('Tela 4')
    ),
    tabPanel(
      title = 'Tela 5',
      h2('Tela 5')
    )
  ),
  tabPanel(
    title = 'Tela 6',
    h2('Tela 6')
  )
)

server <- function(input, output, session) {
  
  output$grafico_1 <- renderPlot({
    plot(mtcars$wt, mtcars$mpg)
  })
  
  output$grafico_2 <- renderPlot({
    plot(mtcars$disp, mtcars$mpg)
  })
  
  output$grafico_3 <- renderPlot({
    plot(mtcars[[input$variavel_1]], mtcars[[input$variavel_1]])
  })
  
}

shinyApp(ui, server)