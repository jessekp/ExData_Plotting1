setwd("C:/Users/jkp/Documents/Coursera/Exploratory Data Analysis/Project 1/exdata_data_household_power_consumption")

#Read data
household_power_consumption <- read.table('household_power_consumption.txt', header=T, sep=';', na.strings="?")

#Read headers
header <- read.table('household_power_consumption.txt', header=T, sep=';', nrows=1)
colnames(household_power_consumption) <- colnames(header)

#Refine data to specific dates
household_power_consumption$datetime <- strptime(paste(household_power_consumption$Date, household_power_consumption$Time), "%d/%m/%Y %H:%M:%S")
dates <- c(as.Date("2007-02-01"), as.Date("2007-02-02"))
household_power_consumption <- household_power_consumption[as.Date(household_power_consumption$datetime) %in% dates,]

#Plot  
png(filename='plot4.png')
par(mfrow=c(2, 2))
with(household_power_consumption, {
  plot(datetime, Global_active_power, type="l", xlab="", ylab="Global Active Power")
  plot(datetime, Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(datetime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering")
  colors <- c("black", "red", "blue")
  variables <- paste("Sub_metering_", 1:3, sep="")
  
  for (i in seq_along(variables)) {
    var <- variables[i]
    data <- household_power_consumption[[var]]
    lines(datetime, data, col=colors[i])
  }
  
  legend("topright", bty="n", legend=variables, col=colors, lty="solid" )
  plot(datetime, Global_reactive_power, type="l")
})
dev.off()