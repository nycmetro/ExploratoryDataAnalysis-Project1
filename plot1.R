# if (!"data.table" %in% installed.packages()) install.packages(data.table)  
# require(data.table) 
# 
# 
# if (!"reshape2" %in% installed.packages()) install.packages(reshape2)  
# require(reshape2) 
# 
# 
# if (!"stringr" %in% installed.packages()) install.packages(stringr)  
# require(stringr) 


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

png("plot1.png", width=480, height=480, units="px")
hist(as.numeric(as.character(Global_active_power)), col="red", main="Global Active Power", xlab="Global Active Power (kilowatts)")
dev.off()
