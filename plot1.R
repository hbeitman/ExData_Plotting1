##Exploratory Data Analysis - Course Project 1
##plot 1

library(dplyr)

#input data, format date
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE)
data$Date<-as.Date(data$Date, format="%d/%m/%Y")

#filter data, remove ?'s and select date range
data <- data %>%
          filter(Global_active_power != "?", Date>="2007-02-01", Date<="2007-02-02") %>%
          select(Global_active_power)

#set global active power data to numeric
data <- as.numeric(as.character(data$Global_active_power))

#plot data
par(mar=c(0,0,0,0))
png(file="plot1.png", width=480, height=480)
hist(data, col="red", main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", axes=FALSE)
axis(side=1, at=seq(0,6,by=2))
axis(side=2, at=seq(0, 1200, by=200))
dev.off()