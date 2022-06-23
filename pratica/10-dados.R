library(shiny)
library(dplyr)
library(ggplot2)

# imdb <- readr::read_rds('../dados/imdb.rds')    # Com .. não é possível executar sem o "Run App"
imdb <- readr::read_rds(here::here('dados/imdb.rds'))    # com 'here' é possível executar com ou sem o "Run App"

# substituia o selectInput por um slider (com intervalo)

ui <- fluidPage(
  h1('Receita vs Orçamento dos Filmes'),
  # selectInput(
  #   inputId = 'ano',
  #   label = 'Selecione um ano',
  #   choices = sort(unique(imdb$ano),decreasing = TRUE),    # imdb$ano |> unique() |> sort()
  #   multiple = TRUE,
  #   selected = c(2000, 2011)
  # ),
  sliderInput(
    inputId = 'ano',
    label = 'Selecione um ano',
    
  )
  plotOutput(outputId = 'grafico')
)

server <- function(input, output, session) {
  
  output$grafico <- renderPlot({
    imdb |> 
      filter(ano %in% input$ano) |> 
      ggplot() +
      aes(x = orcamento, y = receita) +
      geom_point()
  })
  
}

shinyApp(ui, server)