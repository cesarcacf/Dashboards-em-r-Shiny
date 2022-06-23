library(shiny)
library(dplyr)
library(ggplot2)

credito <- readr::read_rds('../dados/credito.rds')

ui <- fluidPage(
  titlePanel('Clientes bons vs clientes ruins para crédito'),  # igual ao h2()
  sidebarLayout(
    sidebarPanel = sidebarPanel(
      sliderInput(
        inputId = 'idade',
        label = 'Selecione a idade',
        min = min(credito$idade),
        max = max(credito$idade),
        value = c(30, 45),
        step = 1
      ),
      br(),
      selectInput(
        inputId = 'estado_civil',
        label = 'Selecioneo estado civil',
        choices = sort(unique(credito$estado_civil)),
        selected = 'solteira(o)',
        multiple = TRUE
      ),
      br(),
      checkboxGroupInput(
        inputId = 'registros',
        label = 'Com respeito às dividas',
        choices = c(
          'Pessoas com dívidas' = 'sim',
          'Pessoas sem dívidas' = 'não'),
        selected = c('não'),
        inline = TRUE
      )
      
    ),
    mainPanel = mainPanel(
      plotOutput(outputId = 'grafico')
    )
  )
)

server <- function(input, output, session) {
  
  output$grafico <- renderPlot({
    credito |> 
      filter(
        idade >= input$idade[1],
        idade <= input$idade[2],
        # idade %in% input$idade[1]:input$idade[2],    # só funciona com números inteiros, pois cria um vetor de números inteiros
        estado_civil %in% input$estado_civil,
        registros %in% input$registros
      ) |> 
      count(status) |> 
      mutate(
        prop = n / sum(n) *100,
        label_prop = scales::percent(prop, scale = 1)
      ) |> 
      ggplot() +
      aes(x = status, y = prop) +
      geom_col() +
      geom_label(aes(x = status, y = prop / 2, label = label_prop), size = 10) +
      labs(y = 'Proporção (%)')
  })
  
}

shinyApp(ui, server)