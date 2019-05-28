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

# Q3: Of the four types of sources indicated by the \color{red}{\verb|type|}type (point, nonpoint, onroad, nonroad) variable, which of these four sources have seen
# decreases in emissions from 1999–2008 for Baltimore City? Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question.
colnames(NEI.Balt)

NEI.Balt$type <- factor(NEI.Balt$type)
agg.NEI.Balt.y.type <- summarize(group_by(NEI.Balt,year, type),sum(Emissions, na.rm = TRUE))
head(agg.NEI.Balt.y.type)
colnames(agg.NEI.Balt.y.type) <- c("year", "type", "tot.emissions")


png(file = "C:/Users/nidilk/Desktop/Neli Dilkova/Programing/Coursera Exploratory Data Analysis 2019/final assignment/plot3.png", 
    width = 480, height = 480)
plot3 <- qplot(year, tot.emissions, data = agg.NEI.Balt.y.type, geom = c("point"), fill = tot.emissions, facets = .~ type, main = "Total Emissions by type in Baltimore over the years")
print(plot3)
dev.off()


# We have outliers in NONPOINT. Check the same graph, but only with medians
median.NEI.Balt.y.type <- summarize(group_by(NEI.Balt,year, type),median(Emissions, na.rm = TRUE))
head(median.NEI.Balt.y.type)
colnames(median.NEI.Balt.y.type) <- c("year", "type", "tot.emissions")

png(file = "C:/Users/nidilk/Desktop/Neli Dilkova/Programing/Coursera Exploratory Data Analysis 2019/final assignment/plot3_2.png", 
    width = 480, height = 480)
plot3 <- qplot(year, tot.emissions, data = median.NEI.Balt.y.type, geom = c("point"), fill = tot.emissions, facets = .~ type, main = "Median Emissions by type in Baltimore over the years")
print(plot3)
dev.off()