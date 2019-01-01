# Download the data
dataset_url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("power.zip")){download.file(dataset_url,"power.zip")}
if(!file.exists("power")){unzip("power.zip",exdir="power")}

# Use data.table package to read the data
library(data.table)
data <- fread("~/power/household_power_consumption.txt",na.strings="?",
              colClasses=c("character","character","numeric","numeric","numeric","numeric",
                           "numeric","numeric","numeric"))
summary(data)
head(data)

# Create data subset and convert the Data and DateTime format
data.subset <- subset(data,Date == ("1/2/2007") | Date == ("2/2/2007"))
data.subset$DateTime <- (paste(data.subset$Date,data.subset$Time))
data.subset[,`:=`(DateTime=as.POSIXct(strptime(DateTime,format="%d/%m/%Y %H:%M:%S")),
                  Date=as.Date(Date,"%d/%m/%Y")
)]
class(data.subset$Date)
class(data.subset$DateTime)
table(data.subset$Date)

# Create plot2
png(filename="plot2.png",width=480,height=480,units="px")
plot.new()
par(mar=c(4,4,2,1))

plot(data.subset$DateTime,
     data.subset$Global_active_power,
     ylab="Global Active Power (kilowatts)",
     xlab="",
     type="l"
)
dev.off()