
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
                        
                                        # plot hiatogram
hist(power_df$Global_active_power,  main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     ylab = "Frequency", col = "red")
                                        # save plot into PNG file
dev.copy(png, "plot1.png", width = 400, height = 400)
dev.off()

