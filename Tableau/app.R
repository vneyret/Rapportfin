library(shiny)

# Define UI for data upload app ----
ui <- fluidPage(
    
    # App title ----
    titlePanel("Uploading Files"),
    
    # Sidebar layout with input and output definitions ----
    sidebarLayout(
        
        # Sidebar panel for inputs ----
        sidebarPanel(
            
            # Input: Select a file ----
            fileInput("file1", "Choose CSV File",
                      multiple = FALSE,
                      accept = c("text/csv",
                                 "text/comma-separated-values,text/plain",
                                 ".csv")),
            
            # Horizontal line ----
            tags$hr(),
            
            # Input: Checkbox if file has header ----
            checkboxInput("header", "Header", TRUE),
            
            # Input: Select separator ----
            radioButtons("sep", "Separator",
                         choices = c(Comma = ",",
                                     Semicolon = ";",
                                     Tab = "\t"),
                         selected = ","),
            
            # Horizontal line ----
            tags$hr(),
            
            # Input: Select number of rows to display ----
            radioButtons("disp", "Display",
                         choices = c(Head = "head",
                                     All = "all"),
                         selected = "head")
            
        ),
        
        # Main panel for displaying outputs ----
        mainPanel(
            
            # Output: Data file ----
            tableOutput("contents")
            
        )
        
    )
)

# D�finition du serveur afin de pouvoir lire le fichier ----
server <- function(input, output) {
    
    output$contents <- renderTable({
        
        # input$file1 sera nul au lancement. Apr�s la s�lection de l'utilisateur
        # et l'importation du fichier, le haut du tableau sera affich� par d�faut,
        # ou toutes les lignes si l'option correspondante a pr�alablement �t� sel�ctionn�e.
        
        req(input$file1)
        
        # quand on lit des fichiers s�par�s par des points-virgules,
        # avoir une virgule comme s�parateur cause une erreur � "read.csv"
        tryCatch(
            {
                df <- read.csv(input$file1$datapath,
                               header = input$header,
                               sep = input$sep)
            },
            error = function(e) {
                # Retourne une safeError si une erreur d'analyse appara�t
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

# Cr�e l'application Shiny ----
shinyApp(ui, server)