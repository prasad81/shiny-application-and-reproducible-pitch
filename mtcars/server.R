#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
data <- mtcars
 
#names(data) <- c("mpg", "cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am","gear", "carb")
#View(data[data$mpg >15 & data$mpg <30,c(1,2,3,4,5,6,7,8,9,10,11)])
# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Data filtering reaction on input parameters
  dataFilter <- reactive({
    paste0("data[data$mpg > ", input$mpg[1], " & data$mpg < ", input$mpg[2], ",c(1,2,3,4,5,6,7,8,9,10,11)]" ) 
  })
  
  # Data filtering
  output$dataTable <-  renderDataTable({
      eval(parse(text = dataFilter()))
  })
   
  
  # Plot rendering
  output$histplot <- renderPlot({
  temp <- paste0("data[data$mpg > ", input$mpg[1], " & data$mpg < ", input$mpg[2], ",c(1)]" )
  temp1 <-  eval(parse(text=temp))
  hist( temp1 , col="blue", breaks=10, xlab = "Miles per gallon"
        , main = "Historgram of Miles per gallon of cars")
  })
})
