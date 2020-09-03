#source("1-data_collection.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(data.table)
require(readr)		## | for data import
require(dplyr)		## | for data manipulation
require(tidyr)		## | for data tidying
require(tibble)		## | for tibbles (enhanced data frames)--part of tidying data
require(stringr)	## | for strings--part of tidying data
require(lubridate)
require(reshape) 


## ---------------- read-in data ------------------------------------------------------------
message("\n\n | 1. Reading data...")
##-list all package functions for [...]
#ls("package:readr") %>% print()

powerUsage   <- read_delim("./downloads/household_power_consumption2.txt", delim = ";")
message("\n\n | | 1.1. viewing data contents...")
powerUsage %>% print()
message("\n\n | | 1.2. viewing each variable's class...")
sapply(powerUsage, class) %>% as.matrix() %>% print()
message("\n\n | | 1.3. viewing variable locations...")
names <- colnames(powerUsage)
newnames <- str_to_lower(names)
setnames(powerUsage, names, newnames)
names(powerUsage) %>% print()

## ---------------- manipulate data ---------------------------------------------------------
message("\n\n | Subsetting data...")
search 	    	     <- powerUsage$date
search2     	     <- grep("^[1-2]/2/2007", search) 
powerUsage2 	     <- powerUsage[search2, ]
powerUsage2$date     <- dmy(powerUsage2$date)
powerUsage3          <- unite(powerUsage2, date, time, col = "date", sep = " ")
powerUsage3$date     <- ymd_hms(powerUsage3$date)
powerUsage4 	     <- reshape::melt(df, id.vars = c("date", "global_active_power", "global_reactive_power", "voltage", "global_intensity"))
powerUsage4          <- as_tibble(powerUsage4)
powerUsage4 %>% print()

##-clear objects after task completed
#rm(list=ls())