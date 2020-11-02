power <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
head(power)

#Format to date type
power$Date <- as.Date(power$Date, "%d/%m/%Y")

#Filter
power <- subset(power, Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))

power <- power[complete.cases(power),]

DateNTime <- paste(power$Date, power$Time)
DateNTime <- setNames(DateNTime,"DateNTime")
power <- power[ ,!(names(power) %in% c("Date","Time"))]
power <- cbind(DateNTime, power)
power$DateNTime <- as.POSIXct(DateNTime)


#Plot 3 
with(power, {plot(Sub_metering_1~DateNTime, type="l",ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~DateNTime,col='Red')
  lines(Sub_metering_3~DateNTime,col='Blue')})
legend("topright", lwd=c(1,1,1), col=c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))