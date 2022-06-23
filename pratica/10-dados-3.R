library(shiny)
library(dplyr)

url <- ('https://raw.githubusercontent.com/williamorim/brasileirao/master/data-raw/csv/matches.csv')  # fonte: https://github.com/williamorim/brasileirao

ui <- fluidPage(
  h1('Jogos do dia'),
  uiOutput(outputId = 'select_temporada'),
  tableOutput(outputId = 'tabela')
)

server <- function(input, output, session) {
  
  dados <- readr::read_csv(url)
  
  output$select_temporada <- renderUI({
    selectInput(
      inputId = 'temporada',
      label = 'Selecione uma temporada',
      choices = sort(unique(dados$season),decreasing = TRUE)
    )
  })
  
  output$tabela <- renderTable({
    
    dados |> 
      mutate(date = format(date, '%d/%m/%Y'),
             season = as.character(season)
             ) |> 
      filter(season == input$temporada)
  
  })
  
}

shinyApp(ui, server)