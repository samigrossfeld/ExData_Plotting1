
# get data file
fileUrl = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if (!file.exists("power.zip")) {    
  download.file(fileUrl, destfile = "power.zip", method = "curl")
  dateDownloaded <- date()
  unzip ("power.zip", exdir = ".")
}

# read part of a file using sql filtering on the specified dates 
library("sqldf")
# read the data for 1/2/2007
power_df1 = read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE,
                         sql = "select * from file where Date = '1/2/2007' ")
# read the data for 2/2/2007
power_df2 = read.csv.sql("household_power_consumption.txt", header = TRUE, sep = ";", stringsAsFactors = FALSE,
                         sql = "select * from file where Date = '2/2/2007' ")

power_df = rbind(power_df1, power_df2)  # merge the two subtable into one

# format a DateTime variable so time series can be plot 
power_df$DateTime = strptime( paste(as.Date(power_df$Date, "%d/%m/%Y"), power_df$Time), "%Y-%m-%d %H:%M:%S")

plot(power_df$DateTime, power_df$Global_active_power, type  = "l", 
     xlab = "", ylab = "Global Active Power (kilowatts)")


# save plot into PNG file
dev.copy(png, "plot2.png", width = 400, height = 400)
dev.off()

