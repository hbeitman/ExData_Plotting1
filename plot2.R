##Exploratory Data Analysis - Course Project 1
##plot 2

library(dplyr)

#input data
data <- read.table("household_power_consumption.txt", sep=";", header=TRUE, stringsAsFactors=FALSE)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")

#filter data, remove ?'s and select date range
data <- data %>%
  filter(Global_active_power != "?", Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03")) %>%
  select(Global_active_power, Date, Time)

##format date and time to POSIXct
data$Date<-paste(data$Date, data$Time, sep=" ")
data$Date<-as.POSIXct(data$Date, format="%Y-%m-%d %H:%M:%S")

#set global active power data to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

#plot data
png(file="plot2.png", width=480, height=480)
plot(data$Date, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
axis(side=2, at=seq(0,6,by=2))
dev.off()