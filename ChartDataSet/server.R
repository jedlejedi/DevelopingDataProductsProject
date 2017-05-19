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
  ds
}

# Define server logic required to draw that chart
shinyServer(function(input, output) {
   
  output$xSelector <- renderUI({
    selectInput("x", "X axis variable:", names(getDataset(input$dataset))) 
  })
  
  output$ySelector <- renderUI({
    selectInput("y", "Y axis variable:", names(getDataset(input$dataset))) 
  })

  output$xyPlot <- renderPlot({
    
    ds <- getDataset(input$dataset)

    xvar <- input$x
    if(is.null(xvar) || !(xvar %in% names(ds))) {
      xvar <- names(ds)[1]
    }

    yvar <- input$y  
    if(is.null(yvar) || !(yvar %in% names(ds))) {
      yvar <- names(ds)[1]
    }

    x <- ds[[xvar]]
    y <- ds[[yvar]]
    
    plot(x,y)

    if(input$showregression) {
      fit <- lm(y ~ x)
      a <- summary(fit)$coefficients[1,1]
      b <- summary(fit)$coefficients[2,1]
      
      abline(a = a, b = b)
    }
    
  })
  
})
