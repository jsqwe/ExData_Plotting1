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

##Open PNG device, create plot1.png in working dir
png(file = "plot1.png")

## Plot histogram of Global active power and send it to file
hist(fd$Global_active_power, main="Global Active Power", 
     xlab= "Global Active Power (kilowatts)", col = "red")

## Close PNG file device
dev.off()
