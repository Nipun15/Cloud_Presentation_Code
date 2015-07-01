library(shiny)


#read in the CFPB complaints file from my computer
indat <- read.csv(file='C:\\Users\\Nipun\\Desktop\\R Projects\\CFPB\\Visual\\data\\CFPB_Consumer_Complaints.csv',header=TRUE)
plotcounts <- table(indat$Submitted.via,indat$Product)

shinyServer(function(input, output) {
  
  output$productPlot <-renderPlot({
    
    barplot(plotcounts[,input$variable], 
            main=input$variable,
            ylab = "Number of complaints",
            xlab = "Complaint Submission",
            col = c("red")
          )
  })

})
