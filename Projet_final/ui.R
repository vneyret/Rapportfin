library(shiny)
library(shinythemes)

ui <- tagList(
  fluidPage(theme = shinytheme("flatly")),
  navbarPage(
   # title=div(img(src="logo.png"), "ISARA Projet Shiny G1"),
   "ISARA Projet Shiny G1",
    
   #Onglet Informations
      tabPanel("Informations",
               fluidRow(column(width=2),
                        column(
                           h3(p("ANOVA à 1 un facteur",style="color:black;text-align:center")),
                           width=8,style="background-color:#e0eee0;border-radius: 8px")
               ),
               
            br(),
            fluidRow(column(width=2, icon("arrow-alt-circle-right","fa-5x"),align="center"),
                  column(
                        p("Cette application a pour but de réaliser une ANOVA à 1 facteur sur tous types de données numérique. Un ANOVA est un test statistique qui permet de tester des données 
                        paramétriques en comparant la moyenne entre plusieurs modalités d'un facteur. Deux hypothèses de travail sont alors testées :",style="color:black;text-align:justify"),
                         withMathJax(),
                        p(strong("H0 : Les moyennes sont toutes égales entre elles. Le facteur n’a pas un effet significatif sur la variable"),style="color:black; text-align:justify; padding:20px;border:1px solid black;background-color:white"),
                        p(strong("H1 : Au moins une des moyennes est différente des autres. Le facteur a un effet significatif sur la variable"),style="color:black; text-align:justify; padding:20px;border:1px solid black;background-color:white"),
                        width=8,style="background-color:#e0eee0 ;border-radius: 8px")
             ),
             
             br(),
             p("A titre d'exemple, nous utilisons un jeu de données provenant d'essais agronomiques
             réalisés sur du petit épeautre. Les essais se sont déroulés sur ", strong("l'année 2019"), "et ont eu lieu sur
             ", strong("9 variétés différentes."), "L'expérimentation s'est déroulée dans le département de l'Aude, une partie dans la Piège, une
             partie dans le Minervois et une troisième partie à l'école d'ingénieur de Purpan.", style="text-align:justify;color:black;background-color:#e0eee0;padding:15px;border-radius:8px"),
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
                           br(),
                           h5(p("Nous affichons la",strong ("moyenne"), "pour les différentes modalités du facteur:", style="text-align:justify;color:black;background-color:#e0ffff;padding:15px;border-radius:8px")),
                           br(),
                           tableOutput("mean"),
                           h5(p("Nous affichons le",strong ("boxplot"), "pour les différentes modalités du facteur. Le boxplot permet de visualiser des mesures statistiques clés telles que la médiane, la moyenne et les quartiles.", style="text-align:justify;color:black;background-color:#e0ffff;padding:15px;border-radius:8px")),
                           plotOutput("boxplot")
                  ),
                  tabPanel("Hypothèses", "This panel is intentionally left blank",
                           plotOutput("plotsindep"),
                           textOutput("shapiro"),
                           textOutput("bartlett")
                  ),
                  tabPanel("Anova", "This panel is intentionally left blank",
                           tableOutput("anov"),
                           ),
                  tabPanel("Résultats", "Ci dessous :",
                           plotOutput("tuck"),
                           tableOutput("classe"))
               )
            ) 
            
            )
      
  )
)