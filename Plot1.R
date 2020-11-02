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

data.class(power$Date)
#Plot 1
hist(power$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col="red")
