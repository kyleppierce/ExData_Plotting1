# Download and extract the data file if it does not already exist in the working directory
if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                "household_power_consumption.zip", method="curl")
  unzip("household_power_consumption.zip")
}

# Read file into R
x = read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# Convert Date and Time from factors to a POSIXlt date
x$Timestamp = strptime(paste(as.character(x$Date), as.character(x$Time)), "%d/%m/%Y %H:%M:%S")

# subset to the dates 2007-02-01 and 2007-02-02
x = x[x$Timestamp>="2007-02-01" & x$Timestamp<"2007-02-03", ]

# Open PNG graphics device
png(filename="plot4.png", width=480, height=480)

# Set up multi-plot
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1), oma = c(2, 0, 2, 0))

# Plot 2x2 grid
with(x, {
  plot(Timestamp, Global_active_power, type="l", xlab="", ylab="Global Active Power")
  plot(Timestamp, Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    lines(Timestamp, Sub_metering_2, col="red")
    lines(Timestamp, Sub_metering_3, col="blue")
    legend("topright", lty=1, bty="n", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Timestamp, Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
})

# Close PNG graphics device
dev.off()