# Reading the file date into R variable "tbl"
# NA values are encoded with "?"
# The columns are separated with ";"

tbl <- read.table("household_power_consumption.txt",stringsAsFactors = FALSE,sep = ";",header = TRUE,na.strings = "?")

# Convert date into Date format
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



# Lets start plotting
# First lets open the png graphics device with the specified width / height
png(filename = "plot1.png",width = 480,height = 480)

# Lets create the plot. This is a histogram with red color and xlabel and title

hist(sub_tbl$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)",main = "Global Active Power")

# Finally close the graphics device so the plot can be saved to disk
dev.off()