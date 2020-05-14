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
  output$mean <- renderTable({tapply(rdt,fac,mean)}, rownames = TRUE, colnames = FALSE)
  
  variances <- tapply(rdt,fac,var)
  plot <- boxplot(rdt~fac, xlab="Varietes", ylab="rendement en qx/ha") # afficher = ok
  output$boxplot <- renderPlot({boxplot(rdt~fac, xlab="Varietes", ylab="Rendement en qx/ha")})
  
  #indépendance
  lm1 <- lm(rdt~fac)
  par(mfrow=c(2,2))
  plotsindep <- plot(lm1) ## (Demande à l'utilisateur + Affiche) Ok si  :
  
  #- Residual, Scale-Location et Constante Leverage : points éparpillés,
  #- Normal Q_Q : points sur la ligne, 
  
  #Normalité
  shapiro.test(lm1$residuals) ## (Affiche) Ok si P-Value > 0,05.
  
  #homoscédasticité
  bartlett.test(rdt~fac) ## (Affiche) OK si P-Value > 0,05.
  
  
  
  #Si les 3 conditions d'hypothèse ne sont pas validées, on ne peut pas faire d'ANOVA, demander si il veut quand même la faire.
  
  
  
  ### Table d'ANOVA
  
  data <- anova(lm(rdt~fac))
  output$anov <- renderTable({data})
  ## Afficher 
  
  # Si P-Value > 0,05, alors on conserve l'hypothèse H0, on n'a pas pu mettre en évidence l'effet du facteur testé.
  # Si P-Value < 0,05 alors on rejete H0, on a pu mettre en évidence un effet du facteur testé.
  
  # Si P-Value <0,05, alors on fait le teste de Tuckey, si non demander si veut le faire quand même.
  TukeyHSD(aov(rdt~fac))
  output$tuck <- renderTable(aov(rdt~fac))
  plot(TukeyHSD(aov(rdt~fac)))
  
  model<-aov(rendement~variete,data = donnes)
  out <- SNK.test(model,"variete", console=TRUE, 
                  main="patata")
  print(SNK.test(model,"variete", group=FALSE))
  
  ## Sort le tableau avec les variétés et les lettres de groupe en face
  
  output$classes <- renderTable({SNK.test(model,"variete", group=FALSE)})
  
}
