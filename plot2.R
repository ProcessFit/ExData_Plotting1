## ExData_Plotting1 Assignment
## Plot 2 - Time series of global active power

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

## Time series of global active power

## Set the graphics device --> PNG with height and width of 480 pixels
png(file="plot2.png",height=480, width=480, unit="px")

## Build the graph
with(d,plot(dt,Global_active_power, type="l", 
        ylab="Global Active Power (kilowatts)", 
        xlab=NA))


## Close the device
dev.off() 

