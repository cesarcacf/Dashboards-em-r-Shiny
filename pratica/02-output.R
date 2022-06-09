library(shiny)
library(ggplot2)
# library(magrittr)   #para utilizar o pipe tradicional %>%

ui <- fluidPage(
  'Um gráfico de barras',
  plotOutput(outputId = 'grafico', height = "600px")
)

server <- function(input, output, session) {

  # output$grafico <- renderPlot({
  #   mtcars$cyl |> 
  #     table() |> 
  #     barplot()
  # })
  
  output$grafico <- renderPlot({
    mtcars |> 
      ggplot(aes(x = cyl)) +
      geom_bar()
  })
  
}

shinyApp(ui, server)
