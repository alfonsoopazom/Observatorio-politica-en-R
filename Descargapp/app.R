#install.packages("shiny")

library(shiny)
library(RMySQL)


#Conexion base de datos

mydb <- dbConnect(MySQL(), 
                  user = "root",
                  password = "password", 
                  dbname ="observatorio",
                  host = 'localhost')

#Lista todas la tablas que existen en la base de datos
dbListTables(mydb)


# Define la aplicacion de interfaz grafica
ui <- fluidPage(

    # Application title
    titlePanel(img(src = "UCEN.jpg", heigth = 280, width = 280)),
   
    tabsetPanel(
        tabPanel("Servidor 1"),
        tabPanel("Servidor 2"),
        tabPanel("Servidor 3"),
        tabPanel("Servidor 4")),
   
    fluidRow(
            ),
             #actionButton("accion", "buscar"),
             #actionButton("accion", "descargar"),
            
   
    
    # Sidebar with a slider input for number of bins 
    sidebarLayout( 
        position = "right",
        sidebarPanel( 
                img(src = "imagen.png", heigth = 280, width = 280),
                br(),
                textInput("usuario","Usuario"),
                textInput("contraseña","Contraseña"),
                submitButton("Ingresar")
                ),
        
        mainPanel(
                
                #h1("Ejemplos de etiquetas HTML en Shiny"),
                #h1("Titulo del panel principal", align = "center", style = "font-family: 'times'; font-si16pt"),
                #h2("Titulo secundario", align = "center"),
                #p("Este es un parrafo para probar las etiquetas equivalentes de HTML"),
                #br(),#Salto de linea en un parrafo
                #strong("Esto es un cadena de texto con Negrita"),
                #h3("Single checkbox"),
                #checkboxInput("var", "A", value = TRUE),
                #textOutput("Variable_elegida")
        )
    )
)
   
# Define server logic required to draw a histogram
server <- function(input, output) 
    {
        output$Variable_elegida <- renderText({ print("Elegiste la letra A",input$var )})
       
    }
    
# Run the application 
shinyApp(ui = ui,  server = server)
