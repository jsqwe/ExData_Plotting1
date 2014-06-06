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

##Open PNG device, create plot3.png in working dir
png(file = "plot3.png")


## Plot Time vs Energy sub metering
with(fd, plot(x=DateTime, y = Sub_metering_1, 
              type = "l", col = "black", ylab = "Energy sub metering"))
with(fd, lines(x=DateTime, y = Sub_metering_2, 
              type = "l", col = "red"))
with(fd, lines(x=DateTime, y = Sub_metering_3, 
               type = "l", col = "blue"))

legend("topright", lty = 1 , col = c("black", "red", "blue"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Close PNG file device
dev.off()