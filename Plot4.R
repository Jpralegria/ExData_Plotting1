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

February_day$Sub_metering_1 <- as.character(February_day$Sub_metering_1)
February_day$Sub_metering_1[February_day$Sub_metering_1=="?"] <- NA
February_day$Sub_metering_1 <- as.numeric(February_day$Sub_metering_1)

February_day$Sub_metering_2 <- as.character(February_day$Sub_metering_2)
February_day$Sub_metering_2[February_day$Sub_metering_2=="?"] <- NA
February_day$Sub_metering_2 <- as.numeric(February_day$Sub_metering_2)

February_day$Sub_metering_3 <- as.character(February_day$Sub_metering_3)
February_day$Sub_metering_3[February_day$Sub_metering_3=="?"] <- NA
February_day$Sub_metering_3 <- as.numeric(February_day$Sub_metering_3)

February_day$Voltage <- as.character(February_day$Voltage)
February_day$Voltage[February_day$Voltage=="?"] <- NA
February_day$Voltage <- as.numeric(February_day$Voltage)

February_day$Global_reactive_power <- as.character(February_day$Global_reactive_power)
February_day$Global_reactive_power[February_day$Global_reactive_power=="?"] <- NA
February_day$Global_reactive_power <- as.numeric(February_day$Global_reactive_power)

png("Plot4.png", width = 480, height = 480)

par(mfrow = c(2, 2))

with(February_day,{ 
  plot(Global_active_power,  xlab = "", ylab = "Global Active Power", type="l", xaxt="n")
  axis(1, at=1,labels="Thu")
  axis(1, at=1440,labels="Fri")
  axis(1, at=2880,labels="Sat")
})

with(February_day,{ 
  plot(Voltage,  xlab = "datetime", ylab = "Voltage", type="l", xaxt="n")
  axis(1, at=1,labels="Thu")
  axis(1, at=1440,labels="Fri")
  axis(1, at=2880,labels="Sat")
})

with(February_day, plot(Sub_metering_1, xlab = "", ylab = "Energy sub metering", type="n", xaxt="n") )
lines(February_day$Sub_metering_1, col="black")
lines(February_day$Sub_metering_2, col="red")
lines(February_day$Sub_metering_3, col="blue")
axis(1, at=1,labels="Thu")
axis(1, at=1440,labels="Fri")
axis(1, at=2880,labels="Sat")
legend("topright", cex=.7, lty = 1, pt.cex = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n")

with(February_day,{ 
  plot(Global_reactive_power,  xlab = "datetime", ylab = "Global_reactive_power", type="l", xaxt="n")
  axis(1, at=1,labels="Thu")
  axis(1, at=1440,labels="Fri")
  axis(1, at=2880,labels="Sat")
})

dev.off()