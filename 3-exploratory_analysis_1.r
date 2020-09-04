source("2-data_cleaning.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(ggplot2)
require(dplyr)		## | for data manipulation

## ---------------- data-viz-1 --------------------------------------------------------------
p1 <- ggplot(powerUsage4, aes(x = global_active_power, fill = ..x..)) 
p1 <- p1 + geom_histogram(bins = 12)
p1 <- p1 + geom_rug()
p1 <- p1 + theme_gray()
p1 <- p1 + labs(x = "Global Active Power (kilowatts)", y = "Frequency")
p1 <- p1 + ggtitle("Global Active Power") + theme(plot.title = element_text(face = "bold", hjust = 0.5))
p1 <- p1 + scale_fill_gradient(low = "lightblue", high = "purple")
p1 <- p1 + theme(legend.position =  c(0.92, 0.9))
p1 %>% print()

ggsave("plot1.png", width = 12.7, height = 12.7, units = "cm")