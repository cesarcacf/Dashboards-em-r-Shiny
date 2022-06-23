library(shiny)
library(bs4Dash)
library(dplyr)
library(shinyWidgets)
library(ggplot2)

imdb <- readr::read_rds('dados/imdb.rds')

ano_min <- min(imdb$ano, na.rm = TRUE)
ano_max <- max(imdb$ano, na.rm = TRUE)

nota_min <- min(imdb$nota_imdb, na.rm = TRUE)
nota_max <- max(imdb$nota_imdb, na.rm = TRUE)

generos <- imdb |> 
  tidyr::separate_rows(generos, sep = '\\|') |>
  pull(generos) |>
  unique() |>
  sort()


ui <- dashboardPage(
  title = 'Dashboard IMDB',   # título da aba. incluído no cabeçalho do HTML.
  dark = TRUE,
  # skin = ,
  dashboardHeader(title = 'IMDB'),
  dashboardSidebar(
    sidebarMenu(
      menuItem('Informações gerais', tabName = 'info', icon = icon('info')),
      menuItem('Elenco', tabName = 'elenco', icon = icon('user'))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(
        tabName = 'info',
        h2('Informações gerais'),
        hr(style = 'border: 1px solid firebrick ; background: firebrick'),
        fluidRow(
          box(
            title = 'Filtros',
            width = 12,
            solidHeader = TRUE,
            status = 'danger',
            fluidRow(
              column(
                offset = 1,
                width = 3,
                sliderInput(
                  inputId = 'ano',
                  label = 'Selecione o período',
                  min = ano_min,
                  max = ano_max,
                  value = c(ano_min, ano_max),
                  step = 1
                )
              ),
              column(
                offset = 1,
                width = 3,
                sliderInput(
                  inputId = 'nota',
                  label = 'Selecione o intervalo de notas',
                  min = nota_min,
                  max = nota_max,
                  value = c(nota_min, nota_max)
                )
              ),
              column(
                offset = 1,
                width = 2,
                # selectInput(
                #   inputId = 'genero',
                #   label = 'Selecione os gêneros',
                #   choices = generos
                # multiple = TRUE
                shinyWidgets::pickerInput(
                  inputId = 'genero',
                  label = 'Selecione os gêneros',
                  choices = generos,
                  selected = generos,
                  multiple = TRUE,
                  options = shinyWidgets::pickerOptions(
                    actionsBox = TRUE,
                    selectAllText = 'Todos',
                    deselectAllText = 'Nenhum'
                  )
                )
              )
            )
          )
        ),
        fluidRow(
          valueBoxOutput(outputId = 'num_filmes', width = 4),
          valueBoxOutput(outputId = 'orc_medio'),
          valueBoxOutput(outputId = 'rec_media')
        ),
        fluidRow(
          column(
            width = 12,
            plotOutput('grafico')
          )
        )
      ),
      # dado um ator/triz ou diretor, mostrar um gráfico com os filmes feitos por essa pessoa e a nota desses filmes
      # pode fazer 2 gráficos: 1 paara atores e outro para diretores
      tabItem(
        tabName = 'elenco',
        h2('Elenco'),
        hr(style = 'border: 1px solid firebrick ; background: firebrick'),
        fluidRow()
      )
    )
  )
)

server <- function(input, output, session) {
  
  dados_filtrados <- reactive({
    imdb |> 
      filter(
        ano %in% c(input$ano[1]:input$ano[2]),
        nota_imdb >= input$nota[1],
        nota_imdb <= input$nota[2],
        # purrr::map_lgl(generos, ~ any(stringr::str_detect(.x, input$genero)))
        stringr::str_detect(generos, paste0(input$genero, collapse = '|'))
      )
  })  
  
  output$num_filmes <- renderValueBox({
    num_filmes <- dados_filtrados() |>
      nrow()
    
    valueBox(
      value = num_filmes,
      subtitle = "Número de filmes",
      icon = icon('hashtag'),
      color = 'gray'
    )
  })
  
  output$orc_medio <- renderValueBox({
    orc_medio <- mean(dados_filtrados()$orcamento, na.rm = TRUE)
    
    valueBox(
      value = scales::dollar(orc_medio, accuracy = 0.01),
      subtitle = "Orçamento médio",
      icon = icon('dollar-sign'),
      color = 'danger'
    )
  })
  
  output$rec_media <- renderValueBox({
    rec_media <- mean(dados_filtrados()$receita, na.rm = TRUE)
    
    valueBox(
      value = scales::dollar(rec_media, accuracy = 0.01),
      subtitle = "Receita média",
      icon = icon('dollar-sign'),
      color = 'lime'
    )
  })
  
  output$grafico <- renderPlot({
    dados_filtrados() |> 
      ggplot() +
      aes(x = ano) +
      geom_bar()
  })
  
}

shinyApp(ui, server)