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
png(filename = "plot2.png", width = 480, height = 480)
Sys.setlocale("LC_TIME", "C")

with(chosen_time, plot(timestamp,Global_active_power, type="l",
                       ylab="Global Active Power (kilowatts)",xlab="") )

dev.off()
