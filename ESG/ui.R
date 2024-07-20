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
ui <- shinyUI(fluidPage(
  
  # Application title
  titlePanel("Statistics Canada's Interactive ESG Performance Rating Tool for Canadian Businesses"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      h1("Enter your values"),
      
      selectInput("geo", "Choose your location:",
                  geo_list$geo),
      
      selectInput("industry", "Choose your irndustry:",
                   industry_list$industry),
      
      textInput("id", "What is your ID number:", value = ""),
      
      textInput("ghg", "How many tonnes of GHGs do you produce:", value = ""),
      
      textInput("employees", "How many employees do you have:", value = ""),
      
      textInput("emp_age", "What is the average age of your employees:", value = ""),
      
      textInput("board", "How many board members do you have:", value = ""),
      
      textInput("women", "How many board members as women:", value = ""),
      
      actionButton("submit_user_response", "Submit your responses")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       plotOutput("distPlot", height = 600),
       h1(""),
       tableOutput("tbl"),
       textOutput("text")  )
  )
))
