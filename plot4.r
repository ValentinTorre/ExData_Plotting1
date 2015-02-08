## Read the data from the file as characters. Then convert Date to date format to extract the two-days subset
## and transform the rest of the columns to numeric
dat<-read.table("household_power_consumption.txt",header = TRUE, sep=";",colClasses="character")
d<-strptime(dat$Date, "%d/%m/%Y")
dat2<-subset(dat, d>="2007-02-01" & d<"2007-02-03")
dat3<-rbind(dat2,dat[as.numeric(rownames(dat2[2880,]))+1,])
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


## Plot 4
png("plot4.png", width = 480, height = 480)

par(mfrow=c(2,2))
## 1,1
with(dat4,plot(Global_active_power,type="l",xlab="",ylab="Global Active Power",xaxt="n"))
ticks <- c(0,1440,2880)
axis(1, at = ticks, labels=wd[ticks+1])
## 1,2
with(dat4,plot(Voltage,type="l",xlab="datetime",ylab="Voltage",xaxt="n"))
ticks <- c(0,1440,2880)
axis(1, at = ticks, labels=wd[ticks+1])
## 2,1
with(dat4,plot(Sub_metering_1,type="l",col="black",xlab="",ylab="Energy sub metering",xaxt="n"))
with(dat4,lines(Sub_metering_2,col="red"))
with(dat4,lines(Sub_metering_3,col="blue"))
legend('topright', names(dat3[7:9]), col=c('black','red', 'blue'), lty=1, bty='n',cex=.75)
ticks <- c(0,1440,2880)
axis(1, at = ticks, labels=wd[ticks+1])
## 2,2
with(dat4,plot(Global_reactive_power,type="l",xlab="datetime",xaxt="n"))
ticks <- c(0,1440,2880)
axis(1, at = ticks, labels=wd[ticks+1])

dev.off()


