# Download and extract the data file if it does not already exist in the working directory
if (!file.exists("household_power_consumption.txt")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", 
                "household_power_consumption.zip", method="curl")
  unzip("household_power_consumption.zip")
}

# Read file into R
x = read.csv("household_power_consumption.txt", header=TRUE, sep=";", na.strings="?")

# Convert Date from a factor to a date
x$Date = as.Date(x$Date, "%d/%m/%Y")

# subset to the dates 2007-02-01 and 2007-02-02
x = x[x$Date=="2007-02-01" | x$Date=="2007-02-02", ]

# Create PNG plot
png(filename="plot1.png", width=480, height=480)
hist(x$Global_active_power, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)")
dev.off()