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

# Create PNG plot

# Open PNG graphics device
png(filename="plot3.png", width=480, height=480)

# Plot
with(x, plot(Timestamp, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering"))
with(x, lines(Timestamp, Sub_metering_2, col="red"))
with(x, lines(Timestamp, Sub_metering_3, col="blue"))
legend("topright", lty=1, col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close PNG graphics device
dev.off()