library(shiny)

ui <- fluidPage(
  textInput(inputId = 'entrada', label = 'Escreva qualquer texto'),
  textOutput(outputId = 'saida')
)

server <- function(input, output, session) {
  
  texto <- reactive({
    print('Passei por aqui')
    input$entrada
  })
  
  output$saida <- renderText({
    texto()
    # input$entrada              # usando essa opção, a reatividade não é executada
  })
}

shinyApp(ui, server)