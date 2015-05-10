# Before we start reading data. Lets check if the data loaded in plot1.R is already in memory
if(!exists("sub_tbl")) {
  message("Data not in memory loading from file")
  # Reading the file date into R variable "tbl"
  # NA values are encoded with "?"
  # The columns are separated with ";"
  
  tbl <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE,sep = ";",header = TRUE,na.strings = "?")
  
  # Convert date into Date format. Ours in dd/mm/yyyy format
  d <- as.Date(tbl$Date,format = "%d/%m/%Y")
  
  # We are only interested in date from 1st and 2nd Feb 2007. So lets subset the table
  ind <- which(d > "2007-01-31" & d < "2007-02-03")
  
  sub_tbl <- tbl[ind,]
  
  # Let's add the datetime column, combining the date and time in one column
  # paste function is used to combine the 2 columns into 1. 
  # strptime is used to convert into date time class.
  sub_tbl$datetime <- strptime(paste(sub_tbl$Date , sub_tbl$Time) ,format = "%d/%m/%Y %H:%M:%S")
  
  # Convert Date column into date format. We will just use our previous conversion
  sub_tbl$Date <- d[ind]
} else {
  message("Using Data in Memory")
}

# Lets start plotting
# First lets open the png graphics device with the specified width / height
png(filename = "plot4.png",width = 480,height = 480)

# Since we need to make a 4 in 1 plot. We will set mfcols parameter first
par(mfcol = c(2,2))

#First plot, same as plot 2
with(sub_tbl, plot(datetime , Global_active_power,type = "l",ylab = "Global Active Power (kilowatts)", xlab = ""))

#Second plot, same as plot 3
with(sub_tbl, {plot(datetime , Sub_metering_1 ,type = "l",ylab = "Energy sub metering", xlab = "")
               lines(datetime , Sub_metering_2, col = "red")
               lines(datetime , Sub_metering_3, col = "blue")})

# Let's add the legend to the top right corner of the plot
legend("topright",lty = 1,legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))

# Third plot, defaults are ok
with(sub_tbl, plot(datetime , Voltage,type = "l"))

# Fourth plot, defaults are ok
with(sub_tbl, plot(datetime , Global_reactive_power,type = "l"))

#Lets close the device to save the plot to file
dev.off()