library(shiny)

ui <- fluidPage(
  textInput(
    inputId = 'email',
    label = 'Escreva seu e-mail',
    value = ''
  ),
  br(),
  actionButton(inputId = 'botao', label = 'Enviar')
)

server <- function(input, output, session) {
  
  observeEvent(input$botao, {
    write(input$email, file = 'emails.txt', append = TRUE)
  })
  
}

shinyApp(ui, server)