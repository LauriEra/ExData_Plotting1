setwd("C:/oppimateriaali/coursera/ds/exploratory/data")
library(dplyr)

power_consump <- read.table("household_power_consumption.txt",nrows = 100000,header=T,sep=";",na.strings="?",
                colClasses = c(rep("character",2),rep("numeric",7) ) )
power_consump <- tbl_df(power_consump)
power_consump$Date <- as.Date(power_consump$Date,format="%e/%m/%Y")#"%D"

start <- as.Date("2007-02-01")
stop <- as.Date("2007-02-02")
chosen_time <- power_consump %>% 
        filter(Date>=start)  %>%
        filter(Date<=stop)

setwd("../ExData_Plotting1")
png(filename = "plot1.png", width = 480, height = 480)

with(chosen_time, hist(Global_active_power,col="red", main="Global Active Power",
                       xlab="Global Active Power (kilowatts)") )

dev.off()
