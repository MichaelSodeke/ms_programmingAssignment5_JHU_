source("2-data_cleaning.r") 

## ---------------- load packages -----------------------------------------------------------
message("\n\n | Importing packages...")
require(ggplot2)
require(ggpubr)
require(dplyr)		## | for data manipulation





## ---------------- sub-plot1 ---------------------------------------------------------------
p1 <- ggplot(powerUsage4, aes(x = date, y = global_active_power)) 
p1 <- p1 + geom_line()
p1 <- p1 + theme_gray()
p1 <- p1 + labs(x = " ", y = "Global Active Power (kilowatts)")
p1 <- p1 + scale_x_datetime(breaks = breaks_width("1 day"), labels = date_format("%a"))
#p1 %>% print()



## ---------------- sub-plot2 ---------------------------------------------------------------
p2 <- ggplot(powerUsage4, aes(x = date, y = voltage)) 
p2 <- p2 + geom_line()
p2 <- p2 + theme_gray()
p2 <- p2 + labs(x = "datetime", y = "voltage")
p2 <- p2 + scale_x_datetime(breaks = breaks_width("1 day"), labels = date_format("%a"))
#p2 %>% print()




## ---------------- sub-plot3 ---------------------------------------------------------------
p3 <- ggplot(powerUsage4, aes(x = date, y = value))
p3 <- p3 + geom_line(aes(color = variable))
p3 <- p3 + scale_fill_gradient2(low = "red", high = "blue", mid = "white", midpoint = 25)
p3 <- p3 + theme_gray()
p3 <- p3 + theme(legend.position =  c(0.80, 0.88), legend.text = element_text(size = 8), legend.key.size = unit(0.2, "cm"), legend.title = element_text(size = 8))
p3 <- p3 + labs(x = " ", y = "Energy Sub Metering")
p3 <- p3 + scale_x_datetime(breaks = breaks_width("1 day"), labels = date_format("%a"))
#p3 %>% print()



## ---------------- sub-plot4 ---------------------------------------------------------------
p4 <- ggplot(powerUsage4, aes(x = date, y = global_reactive_power)) 
p4 <- p4 + geom_point()
p4 <- p4 + geom_segment(aes(x = date, xend = date, y = 0, yend = global_reactive_power))
p4 <- p4 + theme_gray()
p4 <- p4 + labs(x = "datetime", y = "Global Reactive Power")
p4 <- p4 + scale_x_datetime(breaks = breaks_width("1 day"), labels = date_format("%a"))
#p4 <- p4 + labs(y = "Global Reactive Power")
#p4 %>% print()



## ---------------- multi-plot --------------------------------------------------------------
ggarrange(p1, p2, p3, p4, nrow = 2, ncol = 2) %>% print()
ggsave("plot4.png", dp = 72, width = 6, height = 6)


##-clear objects after task completed
#rm(list=ls())
