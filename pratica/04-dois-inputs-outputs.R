library(shiny)

ui <- fluidPage(
  'HISTOGRAMA A',
  selectInput(
    inputId = 'variavel_a',
    label = 'Selecione a variável do histograma A',
    choices = names(mtcars)
  ),
  'HISTOGRAMA B',
  selectInput(
    inputId = 'variavel_b',
    label = 'Selecione a variável do histograma B',
    choices = names(mtcars)
  ),
  plotOutput(outputId = 'histograma_a'),
  plotOutput(outputId = 'histograma_b')
)

server <- function(input, output, session) {
  
  output$histograma_a <- renderPlot({
    print("Calculando o hist A")
    hist(mtcars[[input$variavel_a]])
  })
  
  output$histograma_b <- renderPlot({
    print("Calculando o hist B")
    hist(mtcars[[input$variavel_b]])
  })
  
}

shinyApp(ui, server)