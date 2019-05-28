######
# Code for reading in and reducing air pollution data
# Author: Neli Dilkova-Gnoyke
# May 25th 2019
#####

# read in libraries
library(dplyr)
library(ggplot2)

NEI.Balt <- subset(NEI, fips == 24510)
head(NEI.Balt)

agg.NEI.Balt.by.year <- summarize(group_by(NEI.Balt,year),sum(Emissions, na.rm = TRUE))
colnames(agg.NEI.Balt.by.year) <- c("year", "tot.emissions")


SCC.motors <- SCC[grep("Duty Vehicles", SCC$EI.Sector),]

# Motor vehicles in Baltimore

motor.idx <- as.numeric(unique(gsub("[^0-9]", "", SCC.motors$SCC)))

NEI.Balt$SCC <- gsub("[^0-9]", "",NEI.Balt$SCC)
NEI.Balt$SCC <- as.numeric(as.character(NEI.Balt$SCC))
summary(NEI.Balt$SCC)
head(NEI.Balt$SCC)

NEI.Balt.motors <- subset(NEI.Balt, SCC %in% motor.idx)

agg.NEI.Balt.motors <-  summarize(group_by(NEI.Balt.motors,year),sum(Emissions, na.rm = TRUE))

colnames(agg.NEI.Balt.motors) <- c("year", "tot.emissions")

# Motor vehicles in California

NEI.Cal <- subset(NEI, fips == "06037")
head(NEI.Cal)

NEI.Cal$SCC <- gsub("[^0-9]", "",NEI.Cal$SCC)
NEI.Cal$SCC <- as.numeric(as.character(NEI.Cal$SCC))
summary(NEI.Cal$SCC)
head(NEI.Cal$SCC)


NEI.Cal.motors <- subset(NEI.Cal, SCC %in% motor.idx)

agg.NEI.Cal.motors <-  summarize(group_by(NEI.Cal.motors,year),sum(Emissions, na.rm = TRUE))

colnames(agg.NEI.Cal.motors) <- c("year", "tot.emissions")


# Comparison between Baltimore and California

tot.emiss.Balt.Cal <- agg.NEI.Balt.motors %>% left_join(agg.NEI.Cal.motors, by = "year")
colnames(tot.emiss.Balt.Cal) <- c("year", "Baltimore.emissions", "California.emissions")

rng <- range(tot.emiss.Balt.Cal$Baltimore.emissions, tot.emiss.Balt.Cal$California.emissions)


png(file = "C:/Users/nidilk/Desktop/Neli Dilkova/Programing/Coursera Exploratory Data Analysis 2019/final assignment/plot6.png", 
    width = 480, height = 480)

par(mfrow = c(1,2))
barplot(tot.emiss.Balt.Cal$Baltimore.emissions, xlab = "year", ylim = rng, names.arg = tot.emiss.Balt.Cal$year)
barplot(tot.emiss.Balt.Cal$California.emissions, xlab = "year", ylim = rng,  names.arg = tot.emiss.Balt.Cal$year)
title("Baltimore vs California yearly total emissions", line = -3, outer = TRUE)

dev.off()