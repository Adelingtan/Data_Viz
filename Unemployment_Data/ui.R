# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Unemployment Rate by Counties 2009-2015"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      radioButtons("var",label = "Years", 
                         choices = c("2009", 
                                        "2011", 
                                        "2013" ,
                                        "2015" ),
                         selected = "2009"),
      width=3
    ),
    
    # Show a plot of the generated distribution
    mainPanel(h5("Create Unemployment Rate Maps with 
        information from the US Bureau of Labor Statistics", a("http://www.bls.gov/lau/"),"."),
      plotOutput("map"),width = 9)
  )
))