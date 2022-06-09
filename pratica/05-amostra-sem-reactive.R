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
  
  output$grafico <- renderPlot({
    # set.seed(12)
    amostra <- sample(x = 1:10, size = input$tamanho, replace = TRUE)
    
    # amostra |> 
    #   table() |> 
    #   barplot()

    tibble::tibble(
      numeros = amostra
    ) |>
    ggplot(aes(x = numeros)) +
    geom_bar()
    
  })
  
  output$texto <- renderText({
    # contagem <- amostra |> table
    # num_mais_sorteado <- names (contagem[contagem == max(contagem)])

    # set.seed(12)
    amostra <- sample(x = 1:10, size = input$tamanho, replace = TRUE)
    
    num_mais_sorteado <- tibble::tibble(
      numeros = amostra
    ) |>
      count(numeros) |> 
      filter(n == max(n)) |> 
      pull(numeros)
    
    if(length(num_mais_sorteado) > 1){
      paste("Os números mais sorteados foram", num_mais_sorteado[1], ' e ', num_mais_sorteado[2])
    } else {
        paste("O número mais sorteado foi", num_mais_sorteado[1])
    }
    
  })

}

shinyApp(ui, server)