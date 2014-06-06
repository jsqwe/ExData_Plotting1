## Read data
data <- read.csv2("household_power_consumption.txt", na.strings = "?", 
                  colClasses = c(rep("character",2), rep("numeric", 7)),
                  dec = ".")
## Filter data to only 1/2/2007 and 2/22007
fd <- data[data$Date == "1/2/2007" | data$Date == "2/2/2007",]

## Change Date and Time columns to their appropriate classes
date_time <- paste(fd$Date, fd$Time, sep = " ")
fd$Time <- strptime(date_time,format = "%d/%m/%Y %H:%M:%S")
fd$Date <- as.Date(fd$Date,format = "%d/%m/%Y")
names(fd)[2] <- "DateTime"

##Open PNG device, create plot4.png in working dir
png(file = "plot4.png", res = 55)


## 4 x 4 grid for plotting
par(mfrow = c(2, 2))
with(fd, {
        plot(DateTime, Global_active_power, ylab = "Global Active Power", type = "l")
        plot(DateTime, Voltage, type = "l")
        plot(x=DateTime, y = Sub_metering_1, 
             type = "l", col = "black", ylab = "Energy sub metering")
        lines(x=DateTime, y = Sub_metering_2, type = "l", col = "red")
        lines(x=DateTime, y = Sub_metering_3, type = "l", col = "blue")
        legend("topright", lty = 1 , bty = "n",  col = c("black", "red", "blue"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(DateTime, Global_reactive_power, type = "l")
})

## Close PNG file device
dev.off()