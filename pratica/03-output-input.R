library(shiny)

ui <- fluidPage(
  'Histogramas da base mtcars',
  selectInput(
    inputId = 'variavel',
    label = 'Selecione a variável do histograma',
    choices = names(mtcars)
  ),
  plotOutput(outputId = 'histograma')
)

server <- function(input, output, session) {
  
  output$histograma <- renderPlot({
    hist(mtcars[[input$variavel]])
  })
  
}

shinyApp(ui, server)