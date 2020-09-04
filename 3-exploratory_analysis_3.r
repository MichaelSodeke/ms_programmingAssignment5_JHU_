source("2-data_cleaning.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(ggplot2)
require(dplyr)		## | for data manipulation

## ---------------- data-viz-3 --------------------------------------------------------------
p3 <- ggplot(powerUsage4, aes(x = date, y = value))
p3 <- p3 + geom_line(aes(color = variable))
p3 <- p3 + scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 25)
p3 <- p3 + theme_gray()
p3 <- p3 + theme(legend.position =  c(0.85, 0.9))
p3 <- p3 + labs(y = "Energy Sub Metering")
p3 <- p3 + scale_x_datetime(breaks = breaks_width("1 day"), labels = date_format("%a"))
p3 %>% print()

ggsave("plot3.png", width = 12.7, height = 12.7, units = "cm")