source("2-data_cleaning.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(ggplot2)
require(scales)
require(dplyr)		## | for data manipulation

## ---------------- data-viz-2 --------------------------------------------------------------
p2 <- ggplot(powerUsage4, aes(x = date, y = global_active_power))
p2 <- p2 + geom_line()
p2 <- p2 + theme_gray()
p2 <- p2 + labs(y = "Global Active Power (kilowatts)")
p2 <- p2 + scale_x_datetime(breaks = breaks_width("1 day"), labels = date_format("%a"))
p2 %>% print()

ggsave("plot2.png", width = 12.7, height = 12.7, units = "cm")