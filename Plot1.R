rm(list=ls())

## Set a work directory with setwd("path")

## Unzip file from https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip 

data <- read.table("household_power_consumption.txt", 
                     sep=";", 
                     col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
                     fill=FALSE, 
                     strip.white=TRUE)

data <- data[-c(1),]

data$Date <- as.Date(data$Date, "%d/%m/%Y")

Date_1 <- as.Date("2007-02-01")

Date_2 <- as.Date("2007-02-02")

February_day <- data[data$Date >= Date_1 & data$Date <= Date_2,]

head(February_day, 5)
tail(February_day, 5)

February_day$Global_active_power <- as.character(February_day$Global_active_power)
February_day$Global_active_power[February_day$Global_active_power=="?"] <- NA
February_day$Global_active_power <- as.numeric(February_day$Global_active_power)

png("Plot1.png", width = 480, height = 480)
hist(February_day$Global_active_power, main = "Global Active Power", xlab= "Global Active Power (kilowatts)",col = "red", ylim=c(0,1200))
dev.off()