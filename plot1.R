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

##Plot1

png(filename = "./plot1.png", width = 480, height = 480)

hist(data2$Global_active_power,col="Red",xlab="Global Active Power (kilowatts)",main="Global Active Power")

dev.off()
