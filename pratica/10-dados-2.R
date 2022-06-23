library(shiny)
library(dplyr)

url <- ('https://raw.githubusercontent.com/williamorim/brasileirao/master/data-raw/csv/matches.csv')  # fonte: https://github.com/williamorim/brasileirao

ui <- fluidPage(
  h1('Jogos do dia'),
  dateInput(
    inputId = 'dia',
    label = 'Selecione um dia',
    value = Sys.Date()
  ),
  tableOutput(outputId = 'tabela')
)

server <- function(input, output, session) {
  
  dados <- readr::read_csv(url)
  
  output$tabela <- renderTable({
    tab <- dados |> 
      filter(date == input$dia) |> 
      mutate(
        date = format(date, '%d/%m/%Y')
      ) |> 
      select(
        Dia = date,
        Mandante = home,
        Placar = score,
        Visitante = away
      )
    
    if (nrow(tab) == 0) {
      showModal(
        modalDialog(
          "Nesse dia não houve/não haverá jogos",
          title = 'Aviso',
          footer = modalButton('Fechar'),
          easyClose = TRUE
        )
      )
    }
    
    tab  
    
    })
}

shinyApp(ui, server)