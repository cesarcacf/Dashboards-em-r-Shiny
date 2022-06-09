library(shiny)
# library(geobr)

ui <- fluidPage(
  h1('Formulário'),
  textInput('nome', label = 'Digite o seu nome'),
  numericInput('idade', label = 'Idade', value = 30, min = 18, max = 150),
  selectInput(
    'estado',
    label = 'Estado onde vive',
    choices = c('SP', 'RJ', 'MT', 'BA', 'CE', 'MA', 'AM')
    # choices = unique(geobr::grid_state_correspondence_table$abbrev_state)
  ),
  #textInput("estado", label = "Estado onde vive")
  actionButton('atualizar', label = 'Enviar'),
  br(),br(),
  'Resposta',
  textOutput('resposta')
)

server <- function(input, output, session) {
  
  valores <- eventReactive(input$atualizar, {
    list(
      nome = input$nome,
      idade = input$idade,
      estado = input$estado
    )
  })
  
  output$resposta <- renderText({
    glue::glue(
      'Olá! Eu sou {valores()$nome}, tenho {valores()$idade} e moro em/no {valores()$estado}'
    )
  })
  
}

shinyApp(ui, server)