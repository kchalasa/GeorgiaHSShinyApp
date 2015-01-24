library(shiny)

shinyUI(fluidPage(
  titlePanel("2014 Georgia Public High Schools National Test Scores"),
  sidebarLayout(sidebarPanel(width=3,
                             uiOutput("districtLOV")),
  mainPanel(    
    tabsetPanel(
      tabPanel("SAT",
               fluidRow(
                 dataTableOutput(outputId="satdata")
               )),
      tabPanel("AP",
               fluidRow(
                 dataTableOutput(outputId="apdata")
               )),
      tabPanel("ACT",
               fluidRow(
                 dataTableOutput(outputId="actdata")
               )),
      tabPanel("School Comparison",
               selectInput("assmt", label = "Choose Data Type", 
                           choices = c("SAT","ACT","AP"), selected ="SAT"),
               uiOutput("schoolsLOV"),
               
               hr(),
               textOutput("text1"),
               tags$head(tags$style("#text1{color: red;
                                 font-size: 15px;
                                 }"
               )
               ),
               hr(),
               fluidRow(
                 dataTableOutput(outputId="comparedata")
               ) ) )
    )
  )))