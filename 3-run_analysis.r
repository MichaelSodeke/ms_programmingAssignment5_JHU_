## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(data.table)
require(readr)		## | for data import
require(dplyr)		## | for data manipulation
require(tidyr)		## | for data tidying
require(tibble)		## | for tibbles (enhanced data frames)--part of tidying data
require(stringr)	## | for strings--part of tidying data


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


## ---------------- read-in data ------------------------------------------------------------
message("\n\n | Reading data...")
##-list all package functions for [...]
#ls("package:readr") %>% print()

xtrain 	     <- read_delim("./data/train/X_train.txt", delim = " ", col_names = FALSE, col_types = cols(.default = col_number()))
xtest        <- read_delim("./data/test/X_test.txt", delim = " ", col_names = FALSE, col_types = cols(.default = col_number()))


## ---------------- manipulate data ---------------------------------------------------------
message("\n\n | Organizing data...")
##-merge train and test data
message(" | | 1. merging train and test data...")
x_train_test <- bind_rows(xtrain, xtest) %>% print()

##-add feature varaibles
message("\n | | 2. adding feature varaibles...")
features     <- read_delim("./data/features/features.txt", delim = " ", col_names = FALSE, col_types = cols(.default = col_character()))
fVec1        <- features$X2
fVec2        <- str_to_lower(fVec1)
fVec3        <- gsub("-", "", fVec2)
fVec4        <- gsub("[[:punct:]]", "", fVec3)

##-select variables related to the [mean] and [standard deviation] from dataframe
message("\n | | 3. selecting variables related to the [mean] and [standard deviation] from dataframe...")
fVec5 	     <- grep("mean[xyz]$|std[xyz]$", fVec4, value = TRUE)
positions    <- grep("mean[xyz]$|std[xyz]$", fVec4)  
xtt2         <- x_train_test[ , positions] %>% print()

setnames(xtt2, names(xtt2), fVec5) %>% print()

xtt2 %>% print()

##-add descriptive activites
message("\n | | 4. adding descriptive activites...")
ytrain       <- read_delim("./data/labels/Y_train.txt", delim = " ", col_names = FALSE, col_types = cols(.default = col_number()))
ytest        <- read_delim("./data/labels/Y_test.txt", delim = " ", col_names = FALSE, col_types = cols(.default = col_number()))

y_train_test <- bind_rows(ytrain, ytest)

act          <- read_delim("./data/labels/activity_labels.txt", delim = " ", col_names = FALSE, col_types = cols(
				X1 = col_number(),
				X2 = col_factor())
		)

ytt2 	     <- left_join(y_train_test, act)
ytt2         <- select(ytt2, X2, X1)

res1         <- bind_cols(ytt2, xtt2) 
res2         <- rename(res1, activdesc=X2, activval=X1) %>% print()
res2[[1]]    <- gsub("_", "", res2[[1]])

##-add subjects
message("\n | | 5. adding subjects...")
subject1     <- read_delim("./data/train/subject_train.txt", delim = " ", col_names = FALSE, col_types = cols(.default = col_number()))
subject2     <- read_delim("./data/test/subject_test.txt", delim = " ", col_names = FALSE, col_types = cols(.default = col_number()))
subject3     <- bind_rows(subject1, subject2)

res3         <- bind_cols(subject3, res2)
res4         <- rename(res3, subject=X1) %>% print()

##-find avg for each variable by [activity and subject]
message("\n | | 6. finding the [average] for each variable by [activity and subject]...")
res5         <- group_by(res4, subject, activdesc, activval) %>% summarise_at(vars(tbodyaccmeanx:fbodygyrostdz), mean)

print(res5)

##-fix widths and convert tibble to data.frame for compatability with write.fwf() function
resdf        <- as.data.frame(res5); resdf2 <- resdf

##-display final results
message("\n | | [ ] displaying a final results (columns 1:6)...")
invisible(capture.output(formatInfo   <- write.fwf(x=resdf, formatInfo=T))); colnames(resdf) <- format(colnames(resdf), width=formatInfo$width, justify="centre")
#write.fwf(x = resdf, sep="\t\t\t", quote=FALSE, rownames = T, colnames=T, scientific = TRUE)
write.fwf(x=resdf[, 1:9], width=formatInfo$width[1:9]+10, sep="\t\t")

##-save results in .txt file
#write.fwf(x = resdf, file = "results.txt", quote=FALSE, colnames=T, width=formatInfo$width)
write.table(x=resdf2, file="results.txt", row.names=F, quote=F, sep=", " )

file.show("results.txt")

##-clear objects after task completed
rm(list=ls())