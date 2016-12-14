library(data.table)
library(dplyr)
library(tidyr)
library(plyr)
#Read data
data <- tbl_df(read.table("household_power_consumption.txt", sep = ";") )
# Set more descriptive names
setnames(data,names(data), c("date","time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Select dates between 1/2/2007 and 2/2/2007
datafeb <-filter(data,date %in% c("1/2/2007","2/2/2007")) 
#Create new column with date-time in the format "%d/%m/%Y %H:%M:%S"
datafeb$DateTime <- strptime(paste(datafeb$date,datafeb$time),"%d/%m/%Y %H:%M:%S")
# Open png device to save the plot "plot1.R"
png("plot2.png")
# Call the function to plot the global active power vs the date
plot(datafeb$DateTime, datafeb$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab=NA)
#Close device to save (the file will be saved in the working directory)
dev.off()

