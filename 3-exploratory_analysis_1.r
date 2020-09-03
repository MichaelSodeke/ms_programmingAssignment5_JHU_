#source("1-data_collection.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(ggplot2)
require(dplyr)		## | for data manipulation

p1 <- ggplot(powerUsage4, aes(x = global_active_power)) 
p1 <- p1 + geom_histogram(bins = 18)
p1 <- p1 + geom_rug()
p1 <- p1 + theme_gray()
p1 <- p1 + labs(x = "Global Active Power (kilowatts)", y = "Frequency")
#p1 <- p1 + ggtitle("Global Active Power (kilowatts)") + theme(plot.title = element_text(hjust = 0.5))
p1 %>% print()

ggsave("plot1.png", width = 13.335, height = 13.335, units = "cm")