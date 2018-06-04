# load the required packages
library(shiny)
require(shinydashboard)
library(ggplot2)
library(dplyr)

# library(MASS) # to access Animals data sets
# library(scales) # to access break formatting functions
#library(ggthemes)
library(editheme)
library(RColorBrewer)

###
#++
library(viridis)  # Color palette
library(lubridate)
library(tibble)
library(DT)

##

#pal <- get_pal(theme = "Dracula")

####
source('load.R', local = TRUE)
source('waffle.R', local = TRUE)
#source('dataTables.R', local = TRUE)

#######-------------------

# create the server functions for the dashboard  
server <- function(input, output) { 
  
    Year <- reactive({
    yr <-input$variable
    as.numeric(yr)
    })

    
     ### total number of application in the year
     yrApp <- reactive({    
     d1 <- df %>% 
     group_by(y) %>% 
     summarise(tot=n()) %>%
     filter(y==Year())
     
     Tot1 <- d1$tot
     Tot1
          
     })
     
     ### total number of application in the month
     monthApp <- reactive({    
     d2 <- df %>% 
     group_by(y,mon) %>% 
     summarise(tot=n()) %>%
     filter(y==Year()) %>%
     top_n(tot,n=1)
          
     Tot2 <- as.character(d2$mon)
     Tot2
          
     })
     
     ### total number of application in the month
     dayApp <- reactive({    
     d3 <- df %>% 
     group_by(y,day) %>% 
     summarise(tot=n()) %>%
     filter(y==Year()) %>%
     top_n(tot,n=1)
      
 
     Tot3 <- as.character(d3$day)
     Tot3
          
     })
     
        
   ############################
               
  #creeating the valueBoxOutput content
  output$value1 <- renderValueBox({
    valueBox(
      formatC(yrApp(), format="d", big.mark=',')
      ,paste('Number of Applications')
      ,icon = icon("globe",lib='glyphicon')
      ,color = "purple")
    
    
  })
    
  
  output$value2 <- renderValueBox({
      valueBox(
      formatC(monthApp(), format="d", big.mark=',')
      ,paste('Best performing month')
      ,icon = icon("heart-empty",lib='glyphicon')
      ,color = "green")
    
  })
  
  
  
  output$value3 <- renderValueBox({
      valueBox(
      formatC(dayApp(), format="d", big.mark=',')
      ,paste('Most releases')
      ,icon = icon("fire",lib='glyphicon')
      ,color = "yellow")
    
  })
  
  ## ggplot2
  
    output$yrRelPlot <- renderPlot({
     P1 <- pl.git(Year())  
     P1
     })
     
     
     ## data table: Year 2016
     inYr <- reactive({
     year(input$date)
     })
     
     inMon <- reactive({
     month(input$date)
     })
     
     inDay <- reactive({
     day(input$date)
     })
  
     ## data.table
     selDate <- reactive({
     d4 <- app_df %>%
           filter(y==inYr() & m==inMon() & d==inDay()) %>%
           mutate(date=ymd(date)) %>%
           dplyr::select(-c(y,m,d, free_download)) %>%
           dplyr::select(date,app_id:Cost)
             
      d4      
     
     })
     
     output$tbl1 <- DT::renderDataTable({ 
     #funApp_DT(inYr(),inMon(),inDay())
      dfRank <- selDate()
      datatable(dfRank,class = 'cell-border stripe')%>%formatStyle(1, color = "#f7f7f7", backgroundColor = "#282a36", target = "row") %>%
          formatStyle('Cost',
         backgroundColor = styleEqual(c("Paid", "Free"), c('#FF6A71', '#96C275')))  
     })
     
  
  
 
}
