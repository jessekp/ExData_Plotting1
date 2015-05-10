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
png(filename='Plot1.png', width=480, height=480)
hist(household_power_consumption$Global_active_power, col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
