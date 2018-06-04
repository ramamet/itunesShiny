# load the required packages
library(shiny)
require(shinydashboard)
library(ggplot2)
library(dplyr)

# library(MASS) # to access Animals data sets
# library(scales) # to access break formatting functions
# #library(ggthemes)
#
library(editheme)
library(RColorBrewer)
library(DT)

###
#++
library(viridis)  # Color palette
library(lubridate)
library(tibble)

##----------------
source('load.R', local = TRUE)
source('waffle.R', local = TRUE)
#source('dataTables.R', local = TRUE)
##---------------------

#Dashboard header carrying the title of the dashboard
header <- dashboardHeader(title = "Apple itunes statistics")  

#Sidebar content of the dashboard
sidebar <- dashboardSidebar(
  sidebarMenu(
     
      ## year select
    
     selectInput("variable", label=h4("Year"), 
                     choices = unique(df$y)),              
     submitButton("update",icon("refresh")),
     
     dateInput("date", label = h4("Rank by Date"), value = "2016-01-01",
      min = "2016-01-01", max = "2016-12-30",
      format = "dd/mm/yyyy"),
       submitButton("filter",icon("filter")),
    
   # div(style="display:inline-block;width:50%;text-align: center;",submitButton("update1", label = "update", icon = icon("refresh"))),             
    menuItem("Dashboard", tabName = "dashboard1", icon = icon("dashboard")),
    menuItem("DataTable", tabName = "dataTable1", icon = icon("th-list",lib='glyphicon')),
    menuItem("Data-source", icon = icon("send",lib='glyphicon'), 
             href = "https://github.com/ramamet/applestoreR")
  )
)


frow1 <- fluidRow(
  valueBoxOutput("value1")
  ,valueBoxOutput("value2")
  ,valueBoxOutput("value3")
)

frow2 <- fluidRow(
    box(width=12,align="center",
    title = "Waffle Chart Visualizations"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,plotOutput("yrRelPlot", height ="250px", width="1000px")
    
  )   
)

###
frow3 <- fluidRow(
  box(width=12,align="center",
    title = "Rank List"
    ,status = "primary"
    ,solidHeader = TRUE 
    ,collapsible = TRUE 
    ,DT::dataTableOutput('tbl1')
  )
)


# combine the two fluid rows to make the body
# combine the two fluid rows to make the body
body <- dashboardBody(tabItems(
  tabItem(tags$head(
       tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
      ), 
  tabName = "dashboard1" , frow1, frow2),
  
  tabItem(tags$head(
       tags$link(rel = "stylesheet", type = "text/css", href = "custom.css")
      ), 
  tabName = "dataTable1" , frow3)
  ))

#completing the ui part with dashboardPage
ui <- dashboardPage(title = 'apple_info',
                    header, sidebar, body,
                   skin='purple')
