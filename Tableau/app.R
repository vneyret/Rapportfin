library(shiny)

# Définition de l'UI pour importer des données
ui <- fluidPage(
    
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
        
        # Panneau pour afficher les sorties
        mainPanel(
            
            # Affichage du tableau
            tableOutput("contents")
            
        )
        
    )
)

# Définition du serveur afin de pouvoir lire le fichier ----
server <- function(input, output) {
    
    output$contents <- renderTable({
        
        # input file1 sera nul au lancement. Aprés la sélection de l'utilisateur
        # et l'importation du fichier, le haut du tableau sera affiché par défaut,
        # ou toutes les lignes si l'option correspondante a préalablement été selectionnée.
        
        req(input$file1)
        
        # quand on lit des fichiers séparés par des points-virgules,
        # avoir une virgule comme séparateur cause une erreur ? "read.csv"
        tryCatch(
            {
                df <- read.csv(input$file1$datapath,
                               header = input$header,
                               sep = input$sep)
            },
            error = function(e) {
                # Retourne une safeError si une erreur d'analyse apparaît
                stop(safeError(e))
            }
        )
        
        if(input$disp == "head") {
            return(head(df))
        }
        else {
            return(df)
        }
        
    })
    
}

# Créé l'application Shiny ----
shinyApp(ui, server)