## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(dplyr)		## | for data manipulation


## ---------------- create directory --------------------------------------------------------
message("\n\n | | Creating directory to store data...")
if (!file.exists("data"))
{
	dir.create("data")
}


## ---------------- get link location -------------------------------------------------------
message("\n\n | Requesting URL...")
fileUrl      <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

message(" | | Importing packages...")
##-list parameters for [download.file]
download.file %>% args() %>% print()
#download.file(fileUrl, destfile="./data/Dataset.zip", method="curl")


## ---------------- record date downloaded --------------------------------------------------
message("\n\n | Recording date downloaded...")
downloadedOn <- date()
print(downloadedOn)

message("\n | | Verifying files in created directory...")
print(list.files("./data"))