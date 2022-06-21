############################################
# 
# This script creates the daily files for:
# MEF breakpoint streamflow, wy2020 & wy2021
# from Jake's digitized files in the DataDump.
#
############################################

rm(list = ls())

# Check for and install required packages
for (package in c('readxl', 'tidyverse', 'lubridate', 'writexl', 'zoo')) {
  if (!require(package, character.only=T, quietly=T)) {
    install.packages(package)
    library(package, character.only=T)
  }
}

# Set working directory path
setwd("~/../../Box/External-MEF_DATA/Hydro/Streamflow/L0_subdaily/StripCharts")



#function to convert H:M:S to decimal hours
parse_time <- function(x) {
  res <- do.call(rbind, strsplit(x, ":", TRUE))
  mode(res) <- "numeric"
  c(res %*% (1/c(1, 60, 3600)))
}


wy2020 <- read.csv("~/../../Box/External-MEF_DATA/DataDump/data_entry/Digitization/L0_digitized/S2_weir/corrected/corrected_wy_2020.csv", stringsAsFactors=F)
#select columns of interest
wy2020 <- wy2020[,c("corr_datetime", "corr_y")]
#format timestamp
wy2020$TIMESTAMP <- as.POSIXct(wy2020$corr_datetime, format = "%Y-%m-%d %H:%M:%S", tz = "GMT")
str(wy2020)
summary(wy2020)

wy2021 <- read.csv("~/../../Box/External-MEF_DATA/DataDump/data_entry/Digitization/L0_digitized/S2_weir/corrected/corrected_wy_2021.csv", stringsAsFactors=F)
#select columns of interest
wy2021 <- wy2021[,c("corr_datetime", "corr_y")]
#format timestamp
wy2021$TIMESTAMP <- as.POSIXct(wy2021$corr_datetime, format = "%Y-%m-%d %H:%M:%S", tz = "GMT")
str(wy2021)
summary(wy2021)

dat <- rbind(wy2020, wy2021)
str(dat)
summary(dat)

#create rows for missing days and for 00:00:00/23:59:00 each day:
dat$DAY <- strftime(dat$TIMESTAMP, format = "%Y-%m-%d", tz = "GMT")    
dat$DAY <- as.POSIXct(dat$DAY, format = "%Y-%m-%d", tz = "GMT")    

DAY <- seq(min(dat$DAY), max(dat$DAY), by = "1 day") 

dt1 <- paste(DAY, "00:00:00", sep = " ")
dt2 <- paste(DAY, "23:59:00", sep = " ")

corr_datetime <- as.vector(rbind(dt1, dt2))
corr_y <- as.vector(rep(NA, length(corr_datetime)))

df <- cbind(corr_datetime, corr_y)
df <- as.data.frame(df)
df$TIMESTAMP <- as.POSIXct(df$corr_datetime, format = "%Y-%m-%d %H:%M:%S", tz = "GMT")
df$DAY <- strftime(df$TIMESTAMP, format = "%Y-%m-%d", tz = "GMT")    
df$DAY <- as.POSIXct(df$DAY, format = "%Y-%m-%d", tz = "GMT")     

str(df)
summary(df)

#put together and order by TIMESTAMP:
dat <- rbind(dat, df)
dat$corr_y <- as.numeric(dat$corr_y)
dat <- dat[order(dat$TIMESTAMP),]

#remove first and last rows because they are NA endpoints and that causes a problem with na.approx
dat <- dat[-1,]
dat <- dat[-(length(dat$TIMESTAMP)),]

str(dat)
summary(dat)


#use linear interpolation if gap <= 6 sequential NA values (roughly 3 days)?
dat$dat.interp <- zoo::na.approx(dat$corr_y, x = dat$TIMESTAMP,  method = "linear", maxgap = 6)

View(dat)

write.csv(dat, file = "C:/Users/nlany/Box/External-MEF_DATA/DataDump/data_entry/Digitization/L0_digitized/S2_weir/corrected/formatting_for_Steve.csv", row.names=F)


#make notes on which missing days are periods of no data and which are zero flow. All will be filled with 0 in Steve's code.

dat <- dat[-which(is.na(dat$dat.interp)),]

#extract hour and convert to decimal
dat$HOUR <- strftime(dat$TIMESTAMP, format = "%H:%M:%S", tz = "GMT")
dat$HOUR <- parse_time(dat$HOUR)


#separate into calendar years:
yr2020 <- dat[which(dat$TIMESTAMP < as.POSIXct("2021-01-01 00:00:00", tz = "GMT")),]
summary(yr2020)
yr2021 <- dat[which(dat$TIMESTAMP >= as.POSIXct("2021-01-01 00:00:00", tz = "GMT")),]
summary(yr2021)

#loop for saving individual excel files:

#2020
dir <- "DailyBreakpoint/2020/S2-20/"

days <- unique(yr2020$DAY)

for(i in seq_along(days)){
  temp <- subset(yr2020, DAY == days[i])
  temp <- temp[,c("HOUR", "dat.interp")]
  MON <-toupper(strftime(days[i], format = "%b", tz = "GMT"))
  D <- strftime(days[i], format = "%d", tz = "GMT")
  fp <- paste0(dir,MON,D, ".xlsx")
  
  write_xlsx(temp, path = fp, col_names=F)
}

#2021
dir <- "DailyBreakpoint/2021/S2-21/"

days <- unique(yr2021$DAY)

for(i in seq_along(days)){
  temp <- subset(yr2021, DAY == days[i])
  temp <- temp[,c("HOUR", "dat.interp")]
  MON <-toupper(strftime(days[i], format = "%b", tz = "GMT"))
  D <- strftime(days[i], format = "%d", tz = "GMT")
  fp <- paste0(dir,MON,D, ".xlsx")
  
  write_xlsx(temp, path = fp, col_names=F)
}
