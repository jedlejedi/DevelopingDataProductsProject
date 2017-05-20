#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Exploratory Chart Creator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("dataset", "Dataset:", c("mtcars","airquality", "faithful")),
      uiOutput("xSelector"),
      uiOutput("ySelector"),
      selectInput("color", "Markers Color:", c("blue","red", "black", "purple")),
      checkboxInput("showregression", "Plot Regression Line", FALSE)
    ),
    # Show a plot of the generated distribution
    mainPanel(
      div(
        p("Expolratory Charts Creator is a Shiny application that allows you to create exploratory charts on some of R's most famous datasets"),
        p("Using the controls on the lef hand side you can"),
        tags$ul(
          tags$li("select which dataset you want use"),
          tags$li("select which varaiables you want to plot"),
          tags$li("select the color of the markers"),
          tags$li("specify whether you want a regression line to be plotted")
        ),
        p("The application will automatically update the chart every time one of the input is changed. It will also fit a linear model through the selected variables and display the calculated coefficients below the charts")
      ),
      plotOutput("xyPlot"),
      textOutput("coefs")
    )
  )
))
