library(shiny)
library(maps)
library(mapproj)


csvnames<-c("unemployment09.csv","laucnty11.csv","laucnty13.csv","Workbook3.csv")
counties$Unemployed<-as.numeric(gsub(",","",counties$Unemployed))
source("function.R")
# Define server logic required to draw a histogram
shinyServer(
  function(input, output) {
  
  output$map <- renderPlot({
    data <- switch(input$var, 
                   "2009" = 1, 
                   "2011" = 2, 
                   "2013" = 3,
                   "2015" = 4)
    counties<-read.csv(csvnames[data])
    colnames(counties)<-c("countiesCode","x","y","Counties","Year","Labor_Force","Employed","Unemployed","Rate")
    
  percent_map(var=counties$Rate, "darkgreen", "% Unemployed ")
  
  })
})