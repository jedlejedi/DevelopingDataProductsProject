#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

getDataset <- function(dataset) {
  ds <- mtcars
  
  if(dataset == "airquality") {
    ds <-  airquality
  }
  else if (dataset == "faithful") {
    ds <- faithful
  }
  
  ds
}

getVariable <- function(varname, dataset) {
  if(is.null(varname) || !(varname %in% names(dataset))) {
    varname <- names(dataset)[1]
  }
  dataset[[varname]]
  
}


getCoefs <- function(x , y){
  fit <- lm(y ~ x)
  summary(fit)$coefficients[,1]
}

# Define server logic required to draw that chart
shinyServer(function(input, output) {
   
  output$xSelector <- renderUI({
    selectInput("x", "X axis variable:", names(getDataset(input$dataset))) 
  })
  
  output$ySelector <- renderUI({
    selectInput("y", "Y axis variable:", names(getDataset(input$dataset))) 
  })

  output$colorSelector <- renderUI({
    selectInput("color", "Color variable:", names(getDataset(input$dataset))) 
  })

  output$xyPlot <- renderPlot({
    
    ds <- getDataset(input$dataset)

    x <- getVariable(input$x, ds)
    y <- getVariable(input$y, ds)
    color <-input$color
    
    plot(x,y, col = color)

    if(input$showregression) {
      
      coefs <- getCoefs(x,y)
      abline(a = coefs[1], b = coefs[2])
    }
    
  })
  
  output$coefs <- renderText({
    coefs <- getCoefs(x,y)
    paste("y = ", coefs[2], " * x + ", coefs[1])
  })
  
})
