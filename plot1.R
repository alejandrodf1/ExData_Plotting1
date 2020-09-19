library(dplyr)
data_electric<-read.table("./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?",colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))
data_electric$Date<-as.Date(data_electric$Date, "%d/%m/%Y")
filter_electric<-subset(data_electric, Date>=as.Date("2007-2-1")& Date<=as.Date("2007-2-2"))
##na cases
filter_electric<-filter_electric[complete.cases(filter_electric),]
##let's combine columns date and time
DateTime<- paste(filter_electric$Date, filter_electric$Time)
##name
DateTime<- setNames(DateTime, "DateTime")
##let's remove both column date and time and replace it with DateTime
filter_electric<-filter_electric[, (!names(filter_electric) %in% c("Date", "Time"))]
filter_electric<-cbind(DateTime, filter_electric)
##SET FORMAT
filter_electric$DateTime<-as.POSIXct(DateTime)

##LET'S DO THE PLOTS
par(mfrow=c(1,1))
##code that make imagen 1  
hist(filter_electric$Global_active_power, col = "red", main = ("Global Active Power"), xlab = "Global Active Power (Kilowatts)" )


##code que hace el png
dev.copy(png, file="plot1.png")##copy my plot to a png file
dev.off()#close the png file DO NOT 
