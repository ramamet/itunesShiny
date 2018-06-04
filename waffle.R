#++
library(dplyr)
library(ggplot2)
library(viridis)  # Color palette
#library(ggthemes)
library(lubridate)
library(scales)
library(tibble)
library(editheme)
library(DT)


####
source('load.R', local = TRUE)
####


pl.git <- function(YEAR){

dff <- filter(df,y==YEAR)

d <- dff %>%
            group_by(y,w,wd) %>%
            summarize(cn=n())           
      
            
dd <-as_data_frame(d)            
colnames(dd)[1] <- "year"
colnames(dd)[2] <- "week"
colnames(dd)[3] <- "day"
colnames(dd)[4] <- "hours"

dd$year <- as.character(dd$year)
dd$day <- as.factor(as.character(dd$day))

dd$day <- factor(dd$day, levels=c("Mon","Tues", "Wed","Thurs","Fri","Sat","Sun"))
dd$day <- factor(dd$day, levels=rev(levels(dd$day)))

#+++++++++++++++++++++      
pal <- get_pal(theme = "Ambiance")

gh_waffle <- function(data, pal = "A", dir = -1){

 
    p <- ggplot(data, aes(x = week, y = day, fill = hours)) +
        scale_fill_viridis(name="Apps", 
                           option = pal,  # Variable color palette
                           direction = dir,  # Variable color direction
                           na.value = "#282a36",
                           limits = c(0, max(data$hours))) +
        geom_tile(color = "#e5d0ff", size = 0.3) +
        facet_wrap("year", ncol = 1) +
        theme_editor("Dracula")+
        scale_x_continuous(
            expand = c(0, 0),
            breaks = seq(1, 52, length = 12),
            labels = c("Jan", "Feb", "Mar", "Apr", "May", "Jun",
                       "Jul", "Aug", "Sep", "Oct", "Nov", "Dec")) +
        #theme_tufte(base_family = "Helvetica") +
        theme(axis.title = element_blank(),
              axis.ticks = element_blank(),
              legend.position = "bottom",
              legend.key.width = unit(1, "cm"),
              #strip.background =element_rect(fill="#fff4e6"),
              #strip.text = element_text(hjust = 0.5, face = "bold", size = 14)
              strip.background = element_blank(),
              strip.text.x = element_blank())
    
    print(p)
}

#plot
sp1<-gh_waffle(dd)

print(sp1)


}

