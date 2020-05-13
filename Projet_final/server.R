library(shiny)

server <- function(input, output, session) {
  
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