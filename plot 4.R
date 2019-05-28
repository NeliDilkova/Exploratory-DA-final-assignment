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


# Q4: Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?
# Which code stands for coal combustion? Find out with grep in SCC

class(SCC$EI.Sector)

coal.idx <- unique(SCC[grep("Coal", SCC$EI.Sector),1])
length(coal.idx)
class(coal.idx)
coal.idx <- as.numeric(as.character(coal.idx))

head(NEI)
length(unique(NEI$SCC))
class(NEI$SCC)

# remove the letters from the indicators. 
tst <- gsub("[^0-9]", "", NEI$SCC) 

length(unique(tst))
tst <- as.numeric(tst)
head(tst)

overlap <- coal.idx[(coal.idx %in% tst)]
overlap

NEI.coal <- subset(NEI, SCC %in% coal.idx)

agg.NEI.by.year.coal <- summarize(group_by(NEI.coal,year),sum(Emissions, na.rm = TRUE))
colnames(agg.NEI.by.year.coal) <- c("year", "tot.emissions")

png(file = "C:/Users/nidilk/Desktop/Neli Dilkova/Programing/Coursera Exploratory Data Analysis 2019/final assignment/plot4.png", 
    width = 480, height = 480)

barplot(agg.NEI.by.year.coal$tot.emissions/1000, main = "Total Emissions by coal combustion per Year in Thousands", xlab = "year", names.arg = agg.NEI.by.year.coal$year)
dev.off()