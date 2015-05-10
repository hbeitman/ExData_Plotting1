##Exploratory Data Analysis - Course Project 1
##plot 4

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

#format values to numeric
mutate(data, Global_active_power = as.numeric(Global_active_power), 
      Global_reactive_power = as.numeric(Global_reactive_power),
      Voltage = as.numeric(Voltage),
      Sub_metering_1 = as.numeric(Sub_metering_1),
      Sub_metering_2 = as.numeric(Sub_metering_2),
      Sub_metering_3 = as.numeric(Sub_metering_3))

#plot data
png(file="plot4.png", width=480, height=480)
par(mfrow=c(2,2))

  ##top-left plot
  plot(data$Date, data$Global_active_power, xlab="", ylab="Global Active Power (kilowatts)", type="l")
  axis(side=2, at=seq(0,6,by=2))
  
  ##top-right plot
  plot(data$Date, data$Voltage, ylab = "Voltage", xlab="datetime", type = "l")

  ##bottom-left plot
  plot(data$Date, data$Sub_metering_1, type="l",xlab="", ylab="")
  lines(data$Date, data$Sub_metering_2, type="l",xlab="", ylab="", col="red")
  lines(data$Date, data$Sub_metering_3, type="l",xlab="", ylab="", col="blue")
  axis(side=2, at=seq(0, 30, by=10))
  title(xlab="", ylab="Energy sub metering")
  legend("topright", pch = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1",
        "Sub_metering_2", "Sub_metering_3"), bty="n")
  
  ##bottom-right plot
  plot(data$Date, data$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l")

dev.off()