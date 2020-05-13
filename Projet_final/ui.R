library(shiny)
library(shinythemes)

ui = tagList(
  #shinythemes::themeSelector(),
  navbarPage(
    # theme = "cerulean",  # <--- To use a theme, uncomment this
   # title=div(img(src="logo.png"), "ISARA Projet Shiny G1"),
   "ISARA Projet Shiny G1",
    tabPanel("Informations",
            
             p("Bonjour, cette application utilise un jeu de données provenant d'essais agronomiques
             réalisés sur du petit épeautre. Les essais se sont déroulés sur l'année 2019 et ont eu lieu sur 12 variétés
             différentes. L'expérimentation s'est déroulée dans le département de l'Aude, une partie dans la Piège, une
             partie dans le Minervois et une troisième partie à l'école d'ingénieur de Purpan."),
             br(),
             
               fluidPage(
               img(src ="ptitepeautre.png", align = "center", height = 300 , width = 300 ),
               img(src ="Parcelles.png", align = "right", height = 300, width = 500)
            
             )
    ),
    tabPanel("Données",  sidebarPanel(
      fileInput("file", "File input:"),
      textInput("txt", "Text input:", "general"),
      sliderInput("slider", "Slider input:", 1, 100, 30),
      tags$h5("Default actionButton:"),
      actionButton("action", "Search"),
      
      tags$h5("actionButton with CSS class:"),
      actionButton("action2", "Action button", class = "btn-primary")
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Tableau",
                 h4("Table"),
                 tableOutput("table"),
                 h4("Verbatim text output"),
                 verbatimTextOutput("txtout"),
                 h1("Header 1"),
                 h2("Header 2"),
                 h3("Header 3"),
                 h4("Header 4"),
                 h5("Header 5")
        ),
        tabPanel("Graphique", "This panel is intentionally left blank"),
        tabPanel("Interprétation", "This panel is intentionally left blank")
      )
    )
    )
  )
)