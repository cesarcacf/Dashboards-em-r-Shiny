library(shiny)
library(dplyr)
library(ggplot2)

bd_credito <- readRDS('../dados/credito.rds')
  
ui <- fluidPage(
  selectInput ('estado_civil', label = 'Estado Civil', choices = bd_credito$estado_civil[!is.na(bd_credito$estado_civil)]),
  selectInput ('moradia', label = 'Tipo de Moradia', choices = bd_credito$moradia[!is.na(bd_credito$moradia)]),
  selectInput ('trabalho', label = 'Trabalho', choices = bd_credito$trabalho[!is.na(bd_credito$trabalho)]),
  plotOutput('clientes')
)

server <- function(input, output, session) {
  output$clientes <- renderPlot({
    bd_credito |>
      filter(estado_civil == input$estado_civil,
             moradia == input$moradia,
             trabalho == input$trabalho)|>
      ggplot() +
      aes(x = status) +
      geom_bar()
  })
}

shinyApp(ui, server)