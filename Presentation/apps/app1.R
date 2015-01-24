library(shiny)
require(rCharts)
require(knitr)
write.csv(file="SATTop5.csv",SAT[1:5,])
write.csv(file="APTop10.csv",AP[1:10,])
write.csv(file="ACTTop10.csv",ACT[1:10,])
SATTop5<-read.csv("SATTop5.csv")
APTop10<-read.csv("APTop10.csv")
ACTTop10<-read.csv("ACTTop10.csv")

output$ASSMT<-renderText({
  
                          if(is.null(input$ASSMT)) paste("Please Choose an Assessment Type for Top School in 2014")
                          else if (input$ASSMT=="ACT") as.character(ACTTop10[input$Rnk,]$School)
                          else if (input$ASSMT=="SAT") as.character(SATTop5[input$Rnk,]$School)
                          else if (input$ASSMT=="AP") as.character(APTop10[input$Rnk,]$School)
                          else "Thanks"
                                
                          })

output$ASSMT1<-renderText({
        paste("Thank You...This page is under construction please visit us at a later time.")
})

