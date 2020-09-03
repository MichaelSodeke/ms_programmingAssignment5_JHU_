## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(dplyr)		## | for data manipulation


## ---------------- create directory --------------------------------------------------------
message("\n\n | | Creating directory to store data...")
if (!file.exists("downloads"))
{
	dir.create("downloads")
}


## ---------------- get link location -------------------------------------------------------
message("\n\n | Requesting URL...")
fileUrl      <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

message(" | | Importing packages...")
##-list parameters for [download.file]
download.file %>% args() %>% print()
download.file(fileUrl, destfile="./downloads/Dataset.zip", method="curl")


## ---------------- record date downloaded --------------------------------------------------
message("\n\n | Recording date downloaded...")
downloadedOn <- date()
print(downloadedOn)

message("\n | | Verifying files in created directory...")
print(list.files("./data"))