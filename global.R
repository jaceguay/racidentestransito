library(shinydashboard)
library(leaflet)
library(lubridate)
library(dplyr)

# valores
dados <- read.csv("https://docs.google.com/spreadsheets/d/e/2PACX-1vTukBFwIgjXG73jrvr38ePIQOLqCrD5M5b6F8Kuff2A3QOAuWjeoWDqNWkoa8Q5SStEVN0vh47RokOt/pub?gid=684987162&single=true&output=csv", header=TRUE, stringsAsFactors=FALSE)
dados$longX <- as.numeric(gsub(',','.',dados$longX))
dados$latY <- as.numeric(gsub(',','.',dados$latY))
dados$tipo <- as.factor(dados$tipo)
dados$data <- ymd(dados$data)
dados$mes <- month(dados$data)