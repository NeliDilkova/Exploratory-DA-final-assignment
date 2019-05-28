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

# Q5: How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?
# We need to search for "Light Duty Vehicles" in SCC$EI.Sector

SCC.motors <- SCC[grep("Duty Vehicles", SCC$EI.Sector),]

# Motor vehicles in Baltimore

NEI.Balt <- subset(NEI, fips == 24510)
head(NEI.Balt)

motor.idx <- as.numeric(unique(gsub("[^0-9]", "", SCC.motors$SCC)))

NEI.Balt$SCC <- gsub("[^0-9]", "",NEI.Balt$SCC)
NEI.Balt$SCC <- as.numeric(as.character(NEI.Balt$SCC))
summary(NEI.Balt$SCC)
head(NEI.Balt$SCC)

NEI.Balt.motors <- subset(NEI.Balt, SCC %in% motor.idx)

agg.NEI.Balt.motors <-  summarize(group_by(NEI.Balt.motors,year),sum(Emissions, na.rm = TRUE))

colnames(agg.NEI.Balt.motors) <- c("year", "tot.emissions")

png(file = "C:/Users/nidilk/Desktop/Neli Dilkova/Programing/Coursera Exploratory Data Analysis 2019/final assignment/plot5.png", 
    width = 480, height = 480)

barplot(agg.NEI.Balt.motors$tot.emissions/1000, main = "Total Emissions in Baltimore by motor vehicles per Year in Thousands", xlab = "year", names.arg = agg.NEI.Balt.motors$year)
dev.off()
