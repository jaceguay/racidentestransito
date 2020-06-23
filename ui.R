ui <- dashboardPage(
  skin = "green",
  #
  dashboardHeader(disable = TRUE),
  # Barra lateral
  dashboardSidebar(sidebarMenu(
    menuItem(
      'Dados do período',
      tabName = 'visaogeral',
      icon = icon('table')
    ),
    menuItem('Análise',
             tabName = 'analise',
             icon = icon('chart-area')),
    menuItem('Mapa',
             tabName = 'mapa',
             icon = icon('map')),
    menuItem(
      'Sobre',
      tabName = 'sobre',
      icon = icon('question-circle')
    )
  )),
  # Corpo, itens
  dashboardBody(
    h1('Dados acidentes de trânsito, Itajaí - SC'),
    tabItems(
      # Tab1
      tabItem(tabName = 'visaogeral',
              fluidRow(box(h3(
                'cx1'
              )),
              
              box(h3(
                'cx2'
              )))),
      
      # Tab2
      tabItem(tabName = 'analise',
              fluidRow(box(h2(
                'teste2'
              ))),
              fluidRow(
                box(title = 'Mapa',  width = 400,
                    leafletOutput('mapa'))
              )),
      # Tab3
      tabItem(tabName = 'mapa',
              fluidRow(box(h3(
                'cx1'
              )),
              
              box(h3(
                'cx2'
              )))),
      
      # Tab4
      tabItem(
        tabName = 'sobre',
        hr(),
        h2(
          'Dashboard elaborado para a disciplina de  VISUALIZAÇÃO DE DADOS, Pós-Graduação Big-Data,
                 UNIVERSIDADE DO VALE DO ITAJAÍ'
        ),
        h3(
          'Acadêmicos: Alfonso Monestel, Michel Duarte, Jaceguay Zukoski, William da Silva'
        ),
        h3(
          'Dados cedidos pela Coordenadoria de Trânsito de Itajaí: arquivo .csv.'
        ),
        h3('Tecnologias utilizadas: Leaflet, R-Studio, R-Shiny')
      )
    )
  )
)
