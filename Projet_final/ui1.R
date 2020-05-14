library(shiny)
library(shinythemes)

ui <- tagList(
  fluidPage(theme = shinytheme("sandstone")),
  navbarPage(
   # title=div(img(src="logo.png"), "ISARA Projet Shiny G1"),
   "ISARA Projet Shiny G1",
    
   #Onglet Informations
      tabPanel("Informations",
            
             p("Bonjour, cette application utilise un jeu de données provenant d'essais agronomiques
             réalisés sur du petit épeautre. Les essais se sont déroulés sur ", strong("l'année 2019"), "et ont eu lieu sur
             ", strong("9 variétés différentes."), "L'expérimentation s'est déroulée dans le département de l'Aude, une partie dans la Piège, une
             partie dans le Minervois et une troisième partie à l'école d'ingénieur de Purpan.", style="text-align:justify;color:black;background-color:#f0fff0;padding:15px;border-radius:10px"),
             br(),
             
               fluidPage(
               img(src ="ptitepeautre.png", align = "center", height = 300 , width = 300 ),
               img(src ="Parcelles.png", align = "right", height = 300, width = 500)
                 )
          ),
   
   #Onglet Données
    tabPanel("Charger Tableau",
             # Titre
             titlePanel("Importez votre tableau"),
             
             # Mise en page : disposition de la barre latérale
             sidebarLayout(
               
               # Panneau pour afficher les entrées
               sidebarPanel(
                 
                 # Imput pour sélectionner un fichier
                 fileInput("file1", "Choisissez un fichier .CSV",
                           multiple = FALSE,
                           accept = c("text/csv",
                                      "text/comma-separated-values,text/plain",
                                      ".csv")),
                 
                 # Insertion d'une ligne horizontale
                 tags$hr(),
                 
                 # Input pour insérer un bouton pour voir si le fichier a des en-tête
                 checkboxInput("header", "En-tête", TRUE),
                 
                 
                 # Input pour choisir le type de séparateur
                 radioButtons("sep", "Séparateurs",
                              choices = c(Comma = ",",
                                          Semicolon = ";"),
                                         # Tab = "\t"),
                              selected = ","),
                 
                 
                 # Insertion d'une ligne horizontale
                 tags$hr(),
                 
                 # Input pour choisir le nombre de lignes à afficher
                
               ),
               
               # Panneau pour afficher les sorties
               mainPanel(
                 
                 # Affichage du tableau
                 tableOutput("contents")
                 
               )
               
             )
    ),
             
      
   tabPanel("Interprétation",
            mainPanel(
               tabsetPanel(
                  tabPanel("Description",
                           h4("Table"),
                           verbatimTextOutput("summary")
                           
                  ),
                  tabPanel("Hypothèses", "This panel is intentionally left blank"),
                  tabPanel("Anova", "This panel is intentionally left blank"),
                  tabPanel("Résultats", "Ci dessous :")
               )
            ) 
            
            )
      
  )
)