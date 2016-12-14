library(data.table)
library(dplyr)
library(tidyr)
library(plyr)
#Read data
data <- tbl_df(read.table("household_power_consumption.txt", sep = ";"))
# Set more descriptive names
setnames(data,names(data), c("date","time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"))
# Select dates between 1/2/2007 and 2/2/2007
datafeb <-filter(data,date %in% c("1/2/2007","2/2/2007")) 
#Create new column with date-time in the format "%d/%m/%Y %H:%M:%S"
datafeb$DateTime <- strptime(paste(datafeb$date,datafeb$time),"%d/%m/%Y %H:%M:%S")
# Open png device to save the plot "plot1.R"
png("plot3.png")
# Call the function to make the plots of the energy sub-metering
datafeb <- datafeb %>% mutate( Sub_metering_1 = as.numeric(as.character(Sub_metering_1)),
                            Sub_metering_2 = as.numeric(as.character(Sub_metering_2)),
                            Sub_metering_3 = as.numeric(as.character(Sub_metering_3))) 

plot(datafeb$DateTime, datafeb$Sub_metering_1,type="l",ylab="Energy sub metering",xlab=NA,col="black")
lines(datafeb$DateTime, datafeb$Sub_metering_2, col="red")
lines(datafeb$DateTime, datafeb$Sub_metering_3, col="blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#Close device to save (the file will be saved in the working directory)
dev.off()
