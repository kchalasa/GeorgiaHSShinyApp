source("helpers.R")

library(shiny)


# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Drop-down selection input for School Districts in Georgia
  output$districtLOV <- renderUI({
    selectInput("DATA_LVL", "Choose Data Level - State Level, Specific District or Atlanta Metro School Districts", 
                choices = c("State of Georgia" ,"Atlanta Metro Districts", unique(as.character(SAT2014$District))))
  })
    
  # Drop-down selection input for High Schools in Georgia
  output$schoolsLOV <- renderUI({
    selectInput("Schs", "Choose Schools to Compare", 
                choices = unique(as.character(SAT2014$School)), selected =c("Northview High School","Lambert High School"),multiple=TRUE)
  })
  
  # Filter data based on selections
  # Filter data based on selections
  output$satdata <- renderDataTable({
    
    # If missing input, return to avoid error later in function
    if(is.null(input$DATA_LVL))
      return()
    
    if (input$DATA_LVL=="State of Georgia" ) {
      sat <- SAT2014[,-c(1,2,3)]
    } else {if (input$DATA_LVL!="Atlanta Metro Districts") 
    {
      sat<-SAT2014[SAT2014$District==input$DATA_LVL,-c(1,2,3)]
    } 
    else {
      sat<-SAT2014[SAT2014$District %in% c("Atlanta Public Schools","Cherokee County","Cobb County",                                         
                                           "DeKalb County","Douglas County","Forsyth County","Fulton County","Gwinnett County",
                                           "Buford City","Decatur City","Marietta City"),] 
    }
    }
    sat$Selected.Schools.Rank<-rank(-sat$Avg_Combined, na.last = TRUE,ties.method = "max")
    sat[order(sat$Selected.Schools.Rank),]
    sat
  })
  output$apdata <- renderDataTable({
    # If missing input, return to avoid error later in function
    if(is.null(input$DATA_LVL))
      return()
    
    if (input$DATA_LVL=="State of Georgia" ) {
      ap <- AP2014[,-c(1,2,3)]
    } else {if (input$DATA_LVL!="Atlanta Metro Districts") 
    {
      ap<-AP2014[AP2014$District==input$DATA_LVL,-c(1,2,3)]
    } 
    else {
      ap<-AP2014[AP2014$District %in% c("Atlanta Public Schools","Cherokee County","Cobb County",                                         
                                        "DeKalb County","Douglas County","Forsyth County","Fulton County","Gwinnett County",
                                        "Buford City","Decatur City","Marietta City"),] 
    }
    }
    ap$Selected.Schools.Rank<-rank(-ap$AP_PASS_PCT, na.last = TRUE,ties.method = "max")
    ap[order(ap$Selected.Schools.Rank),]
    ap
  })
  output$actdata <- renderDataTable({
    # If missing input, return to avoid error later in function
    if(is.null(input$DATA_LVL))
      return()
    
    if (input$DATA_LVL=="State of Georgia" ) {
      act <- ACT2014[,-c(1,2,3)]
    } else {if (input$DATA_LVL!="Atlanta Metro Districts") 
    {
      act<-ACT2014[ACT2014$District==input$DATA_LVL,-c(1,2,3)]
    } 
    else   {
      act<-ACT2014[ACT2014$District %in% c("Atlanta Public Schools","Cherokee County","Cobb County",                                         
                                           "DeKalb County","Douglas County","Forsyth County","Fulton County","Gwinnett County",
                                           "Buford City","Decatur City","Marietta City"),] 
    }
    }
    act$Selected.Schools.Rank<-rank(-act$Avg_Composite, na.last = TRUE,ties.method = "max")
    act[order(act$Selected.Schools.Rank),]
    
    act
  })
  output$comparedata <- renderDataTable({
    if (input$assmt=="SAT") {
      compdata <- SAT2014[,c(1,2,3,4)]
      if (length(input$Schs)==2) {
        compdata<-SAT2014[SAT2014$School==input$Schs[1] |SAT2014$School==input$Schs[2],]
      } else
      {
        compdata<-SAT2014[c(1:2),]
      }
      compdata
    } else {
      if (input$assmt=="ACT")  {
        compdata <- ACT2014[,c(1,2,3,4)]
        if (length(input$Schs)==2) {
          compdata<-ACT2014[ACT2014$School==input$Schs[1] |ACT2014$School==input$Schs[2],]
        } else
        {
          compdata<-ACT2014[c(1:2),]
        }
        compdata
      } else
      {
        compdata <- AP2014[,c(1,2,3,4)]
        if (length(input$Schs)==2) {
          compdata<-AP2014[AP2014$School==input$Schs[1] |AP2014$School==input$Schs[2],]
        } else
        {
          compdata<-AP2014[c(1:2),]
        }
        compdata
      }
    }
  })
  
  output$text1 <- renderText({ 
    if (length(input$Schs)==2)
         "Please review schools of your choice below"
    else
      paste("ERROR : Please select ONLY TWO Schools. You have selected ", length(input$Schs), "schools.")
  })
  
})
  
  