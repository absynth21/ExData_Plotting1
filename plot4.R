##Download Zip file and access data

setwd("~/RWorkspace")

#Create a temp space for ZIP file
temp<-tempfile()
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,temp)
data <- read.table(unz(temp, "household_power_consumption.txt"),header = TRUE,sep = ";",colClasses="character")
unlink(temp)

#Subset only required data from dataset
data1<-subset(data,data[,1]=="1/2/2007"|data[,1]=="2/2/2007")

#Create new column with datetime
data1$DateTime<- paste(data1$Date,data1$Time)

#convert characters to correct date format
data1[,1]<-as.Date(strptime(data1[,1],"%d/%m/%Y"),"%d/%m/%Y")
data1[,2]<-as.POSIXct(strptime(data1[,2],"%H:%M:%S"),"%H:%M:%S",tz="")
data1[,10]<-as.POSIXct(strptime(data1[,10],"%d/%m/%Y %H:%M:%S"),"%d/%m/%Y %H:%M:%S",tz="")

#Convert Chr to Numeric format for calculations later
data2<-data1

data2[,3]<-as.numeric(data2[,3])
data2[,4]<-as.numeric(data2[,4])
data2[,5]<-as.numeric(data2[,5])

##Plot4
png(filename = "./plot4.png", width = 480, height = 480)
par(mfrow=c(2,2),mar=c(4,4,2,2))
with(data2,{
    #plot2
    plot(data2$DateTime,data2$Global_active_power,type="o",pch=".", ylab="Global Active Power (kilowatts)",xlab="",cex.lab=0.75)
    
    #plotVoltage plot
    plot(data2$DateTime,data2$Voltage,type="o",pch=".", ylab="Voltage",xlab="datetime",cex.lab=0.75)
    
    #Plot3
    plot(data2$DateTime,data2$Sub_metering_1,type="o",pch=".", ylab="Energy sub metering",xlab="",cex.lab=0.75)
    points(data2$DateTime,data2$Sub_metering_2,type="o",pch=".", col = "Red")
    points(data2$DateTime,data2$Sub_metering_3,type="o",pch=".",col = "blue")
    legend("topright",lty=1,col=c("black","red","blue"),legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),bty="n")
    
    #plot globalreactive power
    plot(data2$DateTime,data2$Global_reactive_power,type="o",pch=".",xlab="datetime",ylab="Global_reactive_power",cex.lab=0.75)
})
dev.off()
