##########################################################################
##                                                                      ##
## Exploratory Data Analysis Course Project 1                           ##
##                                                                      ##
##########################################################################

# Data source: 
# https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip
#
# Measurements of electric power consumption in one household with a 
# one-minute sampling rate over a period of almost 4 years. Different 
# electrical quantities and some sub-metering values are available.
# 
# The following descriptions of the 9 variables in the dataset are taken 
# from the UCI web site (http://archive.ics.uci.edu/ml/): 
#
# 1. Date: Date in format dd/mm/yyyy
# 2. Time: time in format hh:mm:ss
# 3. Global_active_power: household global minute-averaged active power (in kilowatt)
# 4. Global_reactive_power: household global minute-averaged reactive power (in kilowatt)
# 5. Voltage: minute-averaged voltage (in volt)
# 6. Global_intensity: household global minute-averaged current intensity (in ampere)
# 7. Sub_metering_1: energy sub-metering No. 1 (in watt-hour of active energy). 
#    It corresponds to the kitchen, containing mainly a dishwasher, an oven and 
#    a microwave (hot plates are not electric but gas powered).
# 8. Sub_metering_2: energy sub-metering No. 2 (in watt-hour of active energy). 
#    It corresponds to the laundry room, containing a washing-machine, 
#    a tumble-drier, a refrigerator and a light.
# 9. Sub_metering_3: energy sub-metering No. 3 (in watt-hour of active energy). 
#    It corresponds to an electric water-heater and an air-conditioner.

# This script (R script CourseProject1.R) performs the following tasks:
#  
# 1. Loads the data. It uses data from the dates 2007-02-01 and 2007-02-02. 
#    It reads data from those dates only. 
# 2. Makes the plots. The overall goal here is simply to examine how household 
#    energy usage varies over a 2-day period in February, 2007. 
#    The task is to reconstruct the following plots below, all of which were 
#    constructed using the base plotting system.
#    Subtasks: 
#    a) Fork and clone the following GitHub repository: 
#       https://github.com/rdpeng/ExData_Plotting1
#    b) Construct the plot and save it to a PNG file with a width of 
#       480 pixels and a height of 480 pixels. 
#    c) Name each of the plot files as plot1.png, plot2.png, etc.
#    d) Create a separate R code file (plot1.R, plot2.R, etc.) that constructs 
#       the corresponding plot, i.e. code in plot1.R constructs the plot1.png plot. 
#       The code file should include code for reading the data so that the plot 
#       can be fully reproduced. It should also include the code that creates the 
#       PNG file
#    e) Add the PNG file and R code file to your git repository
#    f) Push your git repository to GitHub so that the GitHub version of your 
#       repository is up to date. There should be four PNG files and four R code files


#------------------------------------------------------------------------
# Preparatory steps
#------------------------------------------------------------------------
# Set working directory to datasources location (this will become the repo data location later)
#setwd("./userDir/courseradatascience/ExData_Plotting1")
# use data.table for fast reading 
library(data.table)


#------------------------------------------------------------------------
# Task 1: Loads the data. It uses data from the dates 2007-02-01 and 
#         2007-02-02. It reads data from those dates only.
#------------------------------------------------------------------------
# datasource file location 
file <- "./data/household_power_consumption.txt"

# checks if directory exists  
if(file.exists("data"))
{
  # read data (fast)
  data <- fread(file, na.strings=c("?"))

  # loads data table with selected data only
  DT <- subset(data, as.Date(Date, "%d/%m/%Y") >= as.Date("2007-02-01", "%Y-%m-%d") & as.Date(Date, "%d/%m/%Y")<= as.Date("2007-02-02", "%Y-%m-%d"))
}

#------------------------------------------------------------------------
# Task 2: Makes the plots. It uses the base plotting system
#------------------------------------------------------------------------
# Completes each one of the subtasks for creating Plot1, Plot2, Plot3, and Plot4

#------------------------------------------------------------------------
# Task 2.3: Create Plot3 - Plot of energy sub metering
#------------------------------------------------------------------------
# Uses data in data table DT 


# add extra column with date/time combination
DT[, z:=as.character(paste(Date, Time))]

# checks for figures directory   
if !file.exists("figure")
{
  # create figures directory if it does not exist 
  dir.create("figure")
}

# paints chart on the screen first 
plot(strptime(DT$z, "%d/%m/%Y %H:%M:%S"), as.numeric(DT$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering", col="black")
lines(strptime(DT$z, "%d/%m/%Y %H:%M:%S"), as.numeric(DT$Sub_metering_2),col="red")
lines(strptime(DT$z, "%d/%m/%Y %H:%M:%S"), as.numeric(DT$Sub_metering_3),col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))

# open png device and points it to destination file 
png(file="./figure/plot3.png", width=480, height=480)

# paint plot
plot(strptime(DT$z, "%d/%m/%Y %H:%M:%S"), as.numeric(DT$Sub_metering_1), type="l", xlab="", ylab="Energy sub metering", col="black")
lines(strptime(DT$z, "%d/%m/%Y %H:%M:%S"), as.numeric(DT$Sub_metering_2),col="red")
lines(strptime(DT$z, "%d/%m/%Y %H:%M:%S"), as.numeric(DT$Sub_metering_3),col="blue")
legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1), col=c("black", "red", "blue"))

# closes the device 
dev.off() 

