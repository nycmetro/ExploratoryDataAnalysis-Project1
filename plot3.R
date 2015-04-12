filename = "household_power_consumption.txt"  
dataDir <- "./exdata_data_household_power_consumption"  
dirname <- paste0(dataDir,"/") 


cat("Get the Power Consumption data and write it to the file", filename, "!\nPlease wait ...\n")  


if(!file.exists(dataDir)){  
  cat("Download and unzip data in current working directory:\n", getwd(), "\n...\n")  
  temp <- tempfile()  
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"  
  download.file(fileUrl, temp)  
  unzip(temp)  
  unlink(temp)  
  dateDownloaded <- date()  
}  


powerConsumption <- read.table("household_power_consumption.txt",  header=T, sep=";") 

powerConJanFeb <- powerConsumption[as.character(powerConsumption$Date) %in% c("1/2/2007", "2/2/2007"),]
rm(powerConsumption)

powerConJanFeb$dateTime = paste(powerConJanFeb$Date, powerConJanFeb$Time)

powerConJanFeb$dateTime <- strptime(powerConJanFeb$dateTime, "%d/%m/%Y %H:%M:%S")

attach(powerConJanFeb)

png("plot3.png", width=480, height=480, units="px")
plot(dateTime,as.numeric(as.character(Sub_metering_1)) , xlab="",  ylab="Energey Sub Metering" 
     , type = "l" , ylim=c(0,40))
lines(dateTime,as.numeric(as.character(Sub_metering_2)),col="Red" )
lines(dateTime,as.numeric(as.character(Sub_metering_3)), col="Blue")
legend("topright", lty=1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3" ))
dev.off()
