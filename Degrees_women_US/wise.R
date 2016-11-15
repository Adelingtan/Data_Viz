library(ggplot2)
library(directlabels)
library(reshape2)
library(grid)
library(scales)
setwd("Desktop/data/wise/")
wise<-read.csv("percent-bachelors-degrees-women-usa.csv",header = TRUE)
View(wise)
names(wise)
names(wise)[4] <- "Art"
names(wise)[7] <- "Comm"
names(wise)[8] <- "CS"
names(wise)[12] <- "linguistics"
names(wise)[13] <- "Health"
names(wise)[14] <- "Math & Stat"
names(wise)[17] <- "Public Ad"
names(wise)[18] <- "Humanity"

new_data <- melt(wise, id.vars="Year")
names(new_data)

gg<-ggplot(new_data, aes(x=Year, y=value/100, group =variable , colour =variable)) +
  geom_line(size=1) +
  scale_colour_discrete(guide = 'none') +
  scale_x_continuous(limits=c(1970,2018)) +
  scale_y_continuous(labels = percent,limits=c(0,0.9), breaks=seq(0,0.9,0.1))+
  geom_dl(aes(label = variable), method = list(dl.trans(x = x + 0.2),"last.points", cex = 0.8))+
  labs(title = "Percentage of Bachelor's Degrees Obtained by Women in U.S.",
       x="Year",
       y="")+
  theme_bw()+theme(panel.border = element_blank())
gg
gt1 <- ggplotGrob(gg)
gt1$layout$clip[gt1$layout$name == "panel"] <- "off"
grid.draw(gt1)
