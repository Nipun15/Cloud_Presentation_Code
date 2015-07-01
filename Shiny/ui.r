library(shiny)

#read in the CFPB complaints file from my computer
indat <- read.csv(file='C:\\Users\\Nipun\\Desktop\\R Projects\\CFPB\\Visual\\data\\CFPB_Consumer_Complaints.csv',header=TRUE)


shinyUI(fluidPage(
  titlePanel("CFPB Complaints"),
  
  sidebarLayout(
    sidebarPanel(
      helpText("Select a Product to Display. This will give you the counts by submission type"),
      
      selectInput("variable",
          label = "Product:",
          choices = colnames(plotcounts),
          selected = "Mortgage")
    ),
     
    mainPanel(
      plotOutput("productPlot")
         )
    )
))
