#source("1-data_collection.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(ggplot2)
require(dplyr)		## | for data manipulation

p3 <- ggplot(powerUsage4, aes(x = date, y = value))
p3 <- p3 + geom_line(aes(color = variable))
p3 <- p3 + scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 25)
p3 <- p3 + theme_gray()
p3 <- p3 + theme(legend.position =  c(0.9, 0.9))
p3 <- p3 + labs(y = "Energy Sub Metering")
p3 %>% print()

ggsave("plot3.png", width = 13.335, height = 13.335, units = "cm")