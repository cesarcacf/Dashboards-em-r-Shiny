library(shiny)
library(ggplot2)
library(dplyr)

ui <- fluidPage(
  h1('Sorteando uma amostra'),
  sliderInput(
    inputId = 'tamanho',
    label = 'Selecione o tamanho da amostra',
    min = 1,
    max = 1000,
    value = 100
  ),
  plotOutput(outputId = 'grafico'),
  textOutput(outputId = 'texto')
)

server <- function(input, output, session) {
  
  amostra <-reactive({
    sample(x = 1:10, size = input$tamanho, replace = TRUE)
  })
  
  output$grafico <- renderPlot({
    tibble::tibble(
      numeros = amostra()
    ) |>
      ggplot(aes(x = numeros)) +
      geom_bar()
  })
  
  output$texto <- renderText({
    num_mais_sorteado <- tibble::tibble(
      numeros = amostra()
    ) |>
      count(numeros) |>
      filter(n == max(n)) |> 
      pull(numeros)
    
    if(length(num_mais_sorteado) > 1){
      paste("Os números mais sorteados foram", num_mais_sorteado, collapse = ' ')
    } else {
      paste("O número mais sorteado foi", num_mais_sorteado)
    }
    
  })
  
}

shinyApp(ui, server)