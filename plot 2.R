######
# Code for reading in and reducing air pollution data
# Author: Neli Dilkova-Gnoyke
# May 25th 2019
#####


# read in libraries
library(dplyr)
library(ggplot2)


# read in data
path <- "C:/Users/nidilk/Desktop/Neli Dilkova/Programing/Coursera Exploratory Data Analysis 2019/final assignment/"

NEI <- readRDS(paste0(path, "summarySCC_PM25.rds"))
SCC <- readRDS(paste0(path, "Source_Classification_Code.rds"))

# Q1: Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
#     Using the base plotting system, make a plot showing the total
#     PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008. 

head(NEI)
head(SCC)

# Q2: Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (\color{red}{\verb|fips == "24510"|}fips=="24510") 
# from 1999 to 2008? Use the base plotting system to make a plot answering this question.
NEI.Balt <- subset(NEI, fips == 24510)
head(NEI.Balt)

agg.NEI.Balt.by.year <- summarize(group_by(NEI.Balt,year),sum(Emissions, na.rm = TRUE))
colnames(agg.NEI.Balt.by.year) <- c("year", "tot.emissions")


png(file = "C:/Users/nidilk/Desktop/Neli Dilkova/Programing/Coursera Exploratory Data Analysis 2019/final assignment/plot2.png", 
    width = 480, height = 480)
barplot(agg.NEI.Balt.by.year$tot.emissions/1000, main = "Total Emissions per Year in Baltimore in Thousands", xlab = "year", names.arg = agg.NEI.by.year$year)
dev.off()
