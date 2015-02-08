## Read the data from the file as characters. Then convert Date to date format to extract the two-days subset
## and transform the rest of the columns to numeric
dat<-read.table("household_power_consumption.txt",header = TRUE, sep=";",colClasses="character")
d<-strptime(dat$Date, "%d/%m/%Y")
dat2<-subset(dat, d>="2007-02-01" & d<"2007-02-03")
dat3<-rbind(dat2,dat[as.numeric(rownames(dat3[2880,]))+1,])
d4<-strptime(dat3$Date, "%d/%m/%Y")
wd<-weekdays(d4,abbreviate=TRUE)
dat4<-transform(dat3, Date = as.Date(Date),
                Global_active_power = as.numeric(Global_active_power),
                Global_reactive_power = as.numeric(Global_reactive_power),
                Voltage = as.numeric(Voltage),
                Global_intensity = as.numeric(Global_intensity),
                Sub_metering_1 = as.numeric(Sub_metering_1),
                Sub_metering_2 = as.numeric(Sub_metering_2),
                Sub_metering_3 = as.numeric(Sub_metering_3))

library(datasets)

## Plot 2
png("plot2.png", width = 480, height = 480)
with(dat4,plot(Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",xaxt="n"))
ticks <- c(0,1440,2880)
axis(1, at = ticks, labels=wd[ticks+1])
dev.off()


