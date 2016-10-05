setwd("C:/oppimateriaali/coursera/ds/exploratory/data")
library(dplyr)

power_consump <- read.table("household_power_consumption.txt",nrows = 100000,header=T,sep=";",na.strings="?",
                            colClasses = c(rep("character",2),rep("numeric",7) ) )
power_consump <- tbl_df(power_consump)
power_consump$Date2 <- as.Date(power_consump$Date,format="%e/%m/%Y")#"%D"

start <- as.Date("2007-02-01")
stop <- as.Date("2007-02-02")
chosen_time <- power_consump %>% 
    filter(Date2>=start)  %>%
    filter(Date2<=stop)
chosen_time$timestamp <- strptime(paste(chosen_time$Date,chosen_time$Time),format="%e/%m/%Y %T")

setwd("../ExData_Plotting1")
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
Sys.setlocale("LC_TIME", "C")

with(chosen_time, plot(timestamp,Global_active_power, type="l",
                       ylab="Global Active Power (kilowatts)",xlab="") )

with(chosen_time, plot(timestamp,Voltage, type="l",
                       ylab="Voltage",xlab="datetime"))

with(chosen_time, plot(timestamp,Sub_metering_1, type="l", main="Global Active Power",
                       ylab="Global Active Power (kilowatts)",xlab="") )
with(chosen_time, lines(timestamp,Sub_metering_2,col="red"))
with(chosen_time, lines(timestamp,Sub_metering_3,col="blue"))
legend("topright",col=c(1,2,4),legend=names(chosen_time)[7:9],lty=1, bty='n')#box.lwd = 0,box.col = "white"


with(chosen_time, plot(timestamp,Global_reactive_power,
                       ylab="Global_reactive_power",xlab="datetime",type="s"))

dev.off()
