############################################
# 
# This script appends the annual breakpoint files:
# MEF breakpoint streamflow, 1962 - ongoing.
#
############################################

rm(list = ls())

# nina.lany@usda.gov
# 2022-06-21

# Check for and install required packages
for (package in c('readxl', 'tidyverse', 'lubridate')) {
  if (!require(package, character.only=T, quietly=T)) {
    install.packages(package)
    library(package, character.only=T)
  }
}


#set working directory so it works on both windows and unix OS as long as Box Drive is installed:
path <- "~/../../Box/External-MEF_DATA/Hydro/Streamflow"
if( .Platform$OS.type == "unix" )
  path <- "~/Box/External-MEF_DATA/Hydro/Streamflow"
setwd(path)




##This chunk creates one file per weir with breakpoint values for water years 1961 - 2016:

########
#  S2  #
########

#list files EXCEPT for 1961, which is actually a daily file.
file_list <- list.files("L0_subdaily/StripCharts/AnnualBreakpoint/S2")
file_list2 <- list.files("L0_subdaily/StripCharts/AnnualBreakpoint/S2", pattern = "1961")
file_list <- setdiff(file_list, file_list2)

#make a list to store data:
dat <- list()

for (i in seq_along(file_list)){
  temp <- read_excel(paste0("L0_subdaily/StripCharts/AnnualBreakpoint/S2/", file_list[i]), sheet = 1, col_names = F, skip = 4)
  colnames(temp) <- c("DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")
  dat[[i]] <- temp
}

dat <- do.call(rbind, dat)

dat <- dat %>%
  drop_na(Stage.ft) %>%  ##these are extra rows in Excel spreadsheet with no TIMESTAMP or Stage.ft, but 0 gets automatically filled in for Q and q.
  mutate(Peatland = "S2")
  
dat <- dat[,c("Peatland", "DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")]

#round to three significant digits
dat[,3:6] <- signif(dat[,3:6], 3)

str(dat)
summary(dat)               


write.csv(dat, file = "L1_subdaily/S2_Breakpoint_streamflow_1962-2016.csv", row.names = F)


#########
#  S4N  #
#########

#list files EXCEPT for 1984, which is a weird placeholder with no data.
file_list <- list.files("L0_subdaily/StripCharts/AnnualBreakpoint/S4N")
file_list2 <- list.files("L0_subdaily/StripCharts/AnnualBreakpoint/S4N", pattern = "1984")
file_list <- setdiff(file_list, file_list2)

#make a list to store data:
dat <- list()

for (i in seq_along(file_list)){
  temp <- read_excel(paste0("L0_subdaily/StripCharts/AnnualBreakpoint/S4N/", file_list[i]), sheet = 1, col_names = F, skip = 4)
  colnames(temp) <- c("DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")
  dat[[i]] <- temp
}

dat <- do.call(rbind, dat)

dat <- dat %>%
  drop_na(Stage.ft) %>%
  mutate(Peatland = "S4N")

dat <- dat[,c("Peatland", "DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")]

#round to three significant digits
dat[,3:6] <- signif(dat[,3:6], 3)

str(dat)
summary(dat)               

write.csv(dat, file = "L1_subdaily/S4N_Breakpoint_streamflow_1962-2016.csv", row.names = F)

#########
#  S4S  #
#########

#list files
file_list <- list.files("L0_subdaily/StripCharts/AnnualBreakpoint/S4S")

#make a list to store data:
dat <- list()

for (i in seq_along(file_list)){
  temp <- read_excel(paste0("L0_subdaily/StripCharts/AnnualBreakpoint/S4S/", file_list[i]), sheet = 1, col_names = F, skip = 4)
  colnames(temp) <- c("DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")
  dat[[i]] <- temp
}

dat <- do.call(rbind, dat)

dat <- dat %>%
  drop_na(Stage.ft) %>%
  mutate(Peatland = "S4S")

dat <- dat[,c("Peatland", "DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")]

#round to three significant digits
dat[,3:6] <- signif(dat[,3:6], 3)

str(dat)
summary(dat)               

write.csv(dat, file = "L1_subdaily/S4S_Breakpoint_streamflow_1962-2016.csv", row.names = F)

#########
#  S5  #
#########

#list files
file_list <- list.files("L0_subdaily/StripCharts/AnnualBreakpoint/S5")

#make a list to store data:
dat <- list()

for (i in seq_along(file_list)){
  temp <- read_excel(paste0("L0_subdaily/StripCharts/AnnualBreakpoint/S5/", file_list[i]), sheet = 1, col_names = F, skip = 4)
  colnames(temp) <- c("DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")
  dat[[i]] <- temp
}

dat <- do.call(rbind, dat)

dat <- dat %>%
  drop_na(Stage.ft) %>%
  mutate(Peatland = "S5")

dat <- dat[,c("Peatland", "DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")]

#round to three significant digits
dat[,3:6] <- signif(dat[,3:6], 3)

str(dat)
summary(dat)               

write.csv(dat, file = "L1_subdaily/S5_Breakpoint_streamflow_1962-2016.csv", row.names = F)

#########
#  S6  #
#########

#list files
file_list <- list.files("L0_subdaily/StripCharts/AnnualBreakpoint/S6")

#make a list to store data:
dat <- list()

for (i in seq_along(file_list)){
  temp <- read_excel(paste0("L0_subdaily/StripCharts/AnnualBreakpoint/S6/", file_list[i]), sheet = 1, col_names = F, skip = 4)
  colnames(temp) <- c("DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")
  dat[[i]] <- temp
}

dat <- do.call(rbind, dat)

dat <- dat %>%
  drop_na(Stage.ft) %>%
  mutate(Peatland = "S6")

dat <- dat[,c("Peatland", "DateTime", "Stage.ft", "Q.cfs", "q.mmh", "q.interval")]

#round to three significant digits
dat[,3:6] <- signif(dat[,3:6], 3)

str(dat)
summary(dat)               

write.csv(dat, file = "L1_subdaily/S6_Breakpoint_streamflow_1964-2016.csv", row.names = F)
