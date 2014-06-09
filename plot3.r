#Description: Measurements of electric power consumption in one household with a one-minute sampling rate over a period of almost 4 years.
#Different electrical quantities and some sub-metering values are available

#load the dataset
##library(sqldf)
##DF4 <- read.csv.sql(fn, sql = 'select * from file where Date >= "1985-01-01"')

fileUrl1 = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("./data/household_power_consumption.zip")) {
  download.file(fileUrl1, destfile = "./data/household_power_consumption.zip")
}
#hhpc <- read.table("data/household_power_consumption.txt",header=T,sep=";")
hhpc <- read.table(unz("data/household_power_consumption.zip", "household_power_consumption.txt"),header=T,sep=";")
#convert the neccessary variables to as.Date
#hhpc$Date2 <- strptime(hhpc$Date, "%d/%m/%Y")
hhpc$Date2 <- as.Date(hhpc$Date,"%d/%m/%Y")


#all mising values are recorded as ?
#na.strings=c("?")

#subset a data We will only be using data from the dates 2007-02-01 and 2007-02-02.
#subdata <- hhpc[(hhpc$Date2 %in% "2007-02-01" | hhpc$Date2 %in% "2007-02-02"  ),]
subdata <- subset(hhpc, Date2 == "2007-02-01" | Date2 == "2007-02-02")
#convert the time variable to time format
subdata$Time2 <- strptime(subdata$Time,"%H:%M:%S")
#combine date and time
subdata$DateTime <- paste(subdata$Date, subdata$Time)
subdata$DateTime <-  strptime(subdata$DateTime , "%d/%m/%Y %H:%M:%S")

#plot3
subdata$Sub_metering_1 <- as.character(subdata$Sub_metering_1)
subdata$Sub_metering_1[subdata$Sub_metering_1=="?"] <-NA
subdata$Sub_metering_1 <- as.numeric(as.character(subdata$Sub_metering_1))

subdata$Sub_metering_2 <- as.character(subdata$Sub_metering_2)
subdata$Sub_metering_2[subdata$Sub_metering_2=="?"] <-NA
subdata$Sub_metering_2 <- as.numeric(as.character(subdata$Sub_metering_2))

subdata$Sub_metering_3 <- as.character(subdata$Sub_metering_3)
subdata$Sub_metering_3[subdata$Sub_metering_3=="?"] <-NA
subdata$Sub_metering_3 <- as.numeric(as.character(subdata$Sub_metering_3))


plot(subdata$DateTime , subdata$Sub_metering_1,type="n",ylab="Energy Sub Metering")
lines(subdata$DateTime ,subdata$Sub_metering_1, col="black")
lines(subdata$DateTime ,subdata$Sub_metering_2, col="red")
lines(subdata$DateTime ,subdata$Sub_metering_3, col="blue")
legend("topright",lty=c(1,1,1),  col = c("black", "red","blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
dev.copy(png, file = "plot3.png" ,width = 480, height = 480)  ## Copy my plot to a plot2.PNG file
dev.off()