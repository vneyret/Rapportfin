library(shiny)
library(shinythemes)

ui = tagList(
  fluidPage(theme = shinytheme("sandstone")),
  navbarPage(
   # title=div(img(src="logo.png"), "ISARA Projet Shiny G1"),
   "ISARA Projet Shiny G1",
    tabPanel("Informations",
            
             p("Bonjour, cette application utilise un jeu de données provenant d'essais agronomiques
             réalisés sur du petit épeautre. Les essais se sont déroulés sur ", strong("l'année 2019"), "et ont eu lieu sur
             ", strong("12 variétés différentes."), "L'expérimentation s'est déroulée dans le département de l'Aude, une partie dans la Piège, une
             partie dans le Minervois et une troisième partie à l'école d'ingénieur de Purpan.", style="text-align:justify;color:black;background-color:#f0fff0;padding:15px;border-radius:10px"),
             br(),
             
               fluidPage(
               img(src ="ptitepeautre.png", align = "center", height = 300 , width = 300 ),
               img(src ="Parcelles.png", align = "right", height = 300, width = 500)
                 )
          ),
   
    tabPanel("Données",
            
      sidebarLayout(       
             
      sidebarPanel(h3("Importez vos données"),
      tags$hr(),             
                   
      fileInput("files1", "Choisissez un fichier .CSV",
                multiple = FALSE,
                accept = c("text/csv",
                           "text/comma-separated-values,text/plain",
                           ".csv")),
      tags$hr(),
      
      checkboxInput("header", "En-tête", TRUE),
      
      radioButtons("sep", "Séparateurs",
                   choices = c(Comma = ",",
                               Semicolon = ";",
                               Tab = "\t"),
                   selected = ","),
      
      
      # Insertion d'une ligne horizontale
      tags$hr(),
      
      # Input pour choisir le nombre de lignes à afficher
      radioButtons("disp", "Affichage",
                   choices = c(Head = "En-tête",
                               All = "Tableau en entier"),
                   selected = "En-tête")

    
      ),
    
      mainPanel(
        
      tabsetPanel(
        tabPanel("Tableau",
                 h4("Votre tableau :"),
                 tableOutput("contents")
        
               
        ),
        tabPanel("Graphique", "This panel is intentionally left blank"),
        tabPanel("Interprétation", "This panel is intentionally left blank")
      )
      
    )
    )
  )
  )
)