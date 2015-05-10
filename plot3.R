##Exploratory Data Analysis - Course Project 1
##plot 3

library(dplyr)

#input data
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#filter data, remove ?'s and select date range
data <- data %>%
  filter(Global_active_power != "?", Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))

##format date and time to POSIXct
data$Date<-paste(data$Date, data$Time, sep=" ")
data$Date<-as.POSIXct(data$Date, format="%Y-%m-%d %H:%M:%S")

#format sub-metering variables to numeric
mutate(data, Sub_metering_1 = as.numeric(Sub_metering_1), 
       Sub_metering_2 = as.numeric(Sub_metering_2))

#plot data
png(file="plot3.png", width=480, height=480)
plot(data$Date, data$Sub_metering_1, type="l",xlab="", ylab="")
lines(data$Date, data$Sub_metering_2, type="l",xlab="", ylab="", col="red")
lines(data$Date, data$Sub_metering_3, type="l",xlab="", ylab="", col="blue")
axis(side=1, at=seq(max(data$Date),min(data$Date)))
axis(side=2, at=seq(0, 30, by=10))
title(xlab="", ylab="Energy sub metering")
legend("topright", pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1",
      "Sub_metering_2", "Sub_metering_3"))
dev.off()