#source("1-data_collection.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(ggplot2)
require(dplyr)		## | for data manipulation

p2 <- ggplot(powerUsage4, aes(x = date, y = global_active_power)) 
p2 <- p2 + geom_line()
p2 <- p2 + theme_gray()
p2 <- p2 + labs(y = "Global Active Power (kilowatts)")
p2 %>% print()

ggsave("plot2.png", width = 13.335, height = 13.335, units = "cm")