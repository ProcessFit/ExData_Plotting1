## ExData_Plotting1 Assignment
## Plot 4 - Multiple plots in 4 x 4 grid

## Initial setup
library(data.table) ## Use the data.table library to allow a fast read

## Create a temporary file to download the data, then use fread to read the data
temp <- tempfile()
file <- "household_power_consumption.txt"
zp <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(zp,temp)
d <- fread(unzip(temp,file), na.strings="?")
unlink(temp)
## Check to see expected results
dim(d)
head(d)

## Subset for just the required dates 
## (Add the times in after subsetting .. much quicker!)
d$dt <- as.Date(d$Date,format="%d/%m/%Y")
d <- d[d$dt>=as.Date("2007-02-01") & d$dt<as.Date("2007-02-03"),]

## Update the dt variable .. this time with times, ready for plotting
d$dt <- as.POSIXct(paste(d$Date, d$Time, sep=" "),format="%d/%m/%Y %H:%M:%S")

## Multiple plots in 4 x 4 grid

## Set the graphics device --> PNG with height and width of 480 pixels
png(file="plot4.png",height=480, width=480, unit="px")

## Set up the partitions, fill by columns
par(mfcol = c (2,2))

## Position 1 - Global Active Power Time Series
with(d,plot(dt,Global_active_power, type="l", 
            ylab="Global Active Power (kilowatts)", 
            xlab=NA))

## Position 2 -  Time series of Energy Sub Metering
with(d, {
        plot(dt,Sub_metering_1, type="l", 
             ylab="Energy sub metering", xlab=NA)
        points(dt,Sub_metering_2,col="red", type="l")
        points(dt,Sub_metering_3,col="blue", type="l")
})
legend("topright", legend=names(d)[7:9], col=c("black","red","blue"), lty=1)

# Position 3 - Time series of Voltage
with(d,plot(dt,Voltage, type="l", ylab="Voltage", xlab="datetime"))

## Position 4 - Time series of Gloval reactive power
with(d,plot(dt,Global_reactive_power, type="l",  xlab="datetime"))

## Close the device
dev.off() 

