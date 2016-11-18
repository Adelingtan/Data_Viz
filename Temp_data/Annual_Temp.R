library(ggplot2)

temp<-read.csv("temp_by_month.csv")
temp<-temp[1:1577,]
colnames(temp)<-c("year","month","avg_temp")
temp_year<-aggregate(temp$avg_temp, list(temp$year), mean)
colnames(temp_year)<-c("year","avg_temp")

temp$quarter[temp$month %in% c(1:3)] <- "Winter"
temp$quarter[temp$month %in% c(4:6)] <- "Spring"
temp$quarter[temp$month %in% c(7:9)] <- "Summer"
temp$quarter[temp$month %in% c(10:12)] <- "Autumn"
temp$quarter <- factor(temp$quarter, 
                      levels = c("Spring","Summer","Autumn","Winter"))

new_data<-aggregate(temp$avg_temp, list(temp$year,temp$quarter), mean)
temp_by_season<-new_data[order(new_data$Group.1),] 
colnames(temp_by_season)<-c("year","season","avg_temp")



#####Create the graph#####
gg<-ggplot(temp_by_season, aes(x=year, y=avg_temp,colour =season))+
  geom_point(alpha = 0.7,size = 3)+
  geom_line(data=temp_year, aes(x=year, y=avg_temp),color='red',size=1.3)+
  labs(title = "Average Global and Seasonal Temperature (C), 1800-2011",
       x="Year",
       y="Temperature")+
  scale_y_continuous(limits=c(-1.5,2), breaks=seq(-1.5,2,0.25))+
  theme_bw()+theme(panel.border = element_blank())+
  theme(legend.position = c(.1, 0.75))
gg

