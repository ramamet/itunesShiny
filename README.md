# itunesShiny
ShinyDashboard for Mobile App Usage - Statistics & Facts
----------------
As of now, there were more than million available apps in the Apple’s App Store in the world. 
Our Dashboard gives information on the user can reach of the most popular iphone app in the apple itunes store as of September 2016. The raw data have been webscraped using 'wget' tools from [iTunes Search API](http://www.transtats.bhttps://developer.apple.com/library/content/documentation/AudioVideo/Conceptual/iTuneSearchAPI/SearchExamples.html#//apple_ref/doc/uid/TP40017632-CH6-SW1ts.gov/DatabaseInfo.asp?DB_ID=120&Link=0). The original dataset was json file format and the required data transformation have been carried out using 'R' libraries.

## Raw data
for example,  `281656475.json` from https://itunes.apple.com/lookup?id=281656475&entity=software

## Relevant data source
appstoreR package:
From github, with `devtools::install_github("ramamet/applestoreR")`


## Getting started;

'load shinydashboard' directly from github ,

    library(shiny)
    runGitHub("itunesShiny", "ramamet")    
  
-------------------
## Dashboard Preview

### Dashboard
![p1](https://user-images.githubusercontent.com/16385390/40945433-1388cc5a-6859-11e8-8451-e4a28d8b8a03.png)


### DataTable
![p2](https://user-images.githubusercontent.com/16385390/40945461-387a763a-6859-11e8-8fc7-3210e625c616.png)

## Licence
The MIT License

Copyright (c) 2018 Ramanathan Perumal
