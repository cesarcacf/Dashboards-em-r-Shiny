library(shiny)
library(dplyr)
library(ggplot2)

ssp <- readr::read_rds(here::here('dados/ssp.rds'))

ui <- fluidPage(
  sidebarLayout(
    sidebarPanel(
      selectInput(
        inputId = 'regiao',
        label = 'Selecione uma região',
        choices = sort(unique(ssp$regiao_nome))
        ),
      selectInput(
        inputId = 'muni',
        label = 'Selecione um município',
        choices = c('Carregando...' = '')
      )
    ),
    mainPanel(
      plotOutput('grafico')
    )
  )
)

server <- function(input, output, session) {
  
  observe({
    opcoes <- ssp |> 
      filter(regiao_nome == input$regiao) |> 
      pull(municipio_nome) |> 
      unique()
    
    updateSelectInput(
      session = session,
      inputId = 'muni',
      choices = opcoes
    )
  })
  
  output$grafico <- renderPlot({
    ssp |> 
      filter(municipio_nome == input$muni) |> 
      group_by(ano) |> 
      summarise(
        media_anual = mean(roubo_total, na.rm = TRUE)
      ) |> 
      ggplot() +
      aes(x = ano, y = media_anual) +
      geom_col()
  })
  
}

shinyApp(ui, server)