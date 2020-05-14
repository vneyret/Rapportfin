library(shiny)
library("agricolae")

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
    
  })
  donnes <- read.table("activableR19.csv", header = TRUE, sep = ",")
  #donnes <- df
  dim(donnes)
  names(donnes)
  table(donnes$variete)
  
  ### Variables
  rdt <- donnes$rendement #a faire un lien avec le tableau importé ou un text input "nom de votre colonne variable"
  fac <- as.factor(donnes$variete) #a faire un lien avec le tableau importé ou un text input "nom de votre colonne facteur"
  moyennes <- tapply(rdt,fac,mean) # afficher = ok
  output$mean <- renderTable({tapply(rdt,fac,mean)}, rownames = TRUE)
  
  variances <- tapply(rdt,fac,var)
  plot <- boxplot(rdt~fac, xlab="Varietes", ylab="rendement en qx/ha") # afficher = ok
  output$boxplot <- renderPlot({boxplot(rdt~fac, xlab="Varietes", ylab="Rendement en qx/ha")})
  
  #indépendance
  lm1 <- lm(rdt~fac)
  par(mfrow=c(2,2))
  plotsindep <- plot(lm1) ## (Demande à l'utilisateur + Affiche) Ok si  :
}