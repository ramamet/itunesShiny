library(ggplot2)
library(dplyr)
library(MASS) # to access Animals data sets
library(scales) # to access break formatting functions
library(lubridate)
library(tibble)


##----------------
app <- read.csv('data/itunes_applications.csv',stringsAsFactors = F,header=T)

##+++++++++++++++++++++++
app$date <- as.POSIXct(app$release_date, tz = "UTC")
app$y <- year(app$date)
app$m <- month(app$date)
app$d <- day(app$date)
app$wd <- wday(app$date,label = TRUE)
app$w <- week(app$date)
app$day <- wday(app$date,label = TRUE,abbr = FALSE)
app$mon <- month(app$date,abbr=FALSE,label=TRUE)

df <- app %>%
      dplyr::select(id,date,y,m,d,wd,w,day,mon) %>%
      arrange(desc(y))
      
#########

rank <- read.csv("data/itunes_application_ranks.csv")
rank$date <- as.POSIXct(rank$created_at, tz = "UTC")
rank$y <- year(rank$date)
rank$m <- month(rank$date)
rank$d <- day(rank$date)

app_sub <- dplyr::select(app,id,title,release_date,free_download)
colnames(app_sub)[1] <- "app_id"
colnames(rank)[2] <- "app_id"

app_df <- merge(rank,app_sub,by="app_id",all.x=TRUE)
app_df <- app_df[,-2]

app_df <- app_df[,c(1,7,2,3,4,5,6,8,9)]
app_df <- as_data_frame(app_df)

app_df <- mutate(app_df, Cost = ifelse(free_download == "f", "Paid", "Free"))
