###########################################
# R Code for Downloading Springer Texbooks
###########################################
# Author: Guilhermino Neto, G. (guilherme.neto@ifes.edu.br)
# v 1.0
# Last update: 04.29.2020

##############
# Preparation
##############
# uncomment if needed
# install.packages('utils')
# install.packages('dplyr')
# install.packages('curl')

library(utils)
library(dplyr)
library(curl)

setwd("~/Books")

books <- read.csv("Free+English+textbooks.csv",sep=';')

############
# Download
############

titles <- as.character(books$ï..Book.Title)
genre  <- books$English.Package.Name
urls   <- as.character(books$OpenURL)

curls <- c()

k <- 1

for(url in urls) {
  curls[k] <- curl_fetch_memory(url)[1]
  k <- k+1
}

rm(k)

curls <- gsub('book','content/pdf',curls)
curls <- paste(curls,'.pdf',sep='')

# Make dirs
for(i in levels(genre)) {
  dir.create(i)  
}

genre <- as.character(genre)

# Download
for (i in 1:nrow(books)) {
  download.file(curls[i], destfile = paste(genre[i],'/',titles[i],sep=''),mode="wb")
}
