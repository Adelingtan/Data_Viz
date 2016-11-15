library("ggplot2")
library("dplyr")
#setwd("/Users/addytan/Desktop/data/")
#data manipulation
election<-read.csv("election.csv",header = FALSE)
election<-election[-57:-60,]
election<-election[-1:-5,]
election<-election[,-8:-9]
colnames(election)<-c("STATE","ELECTORAL_VOTE","POPULAR_VOTE","OBAMA","ROMNEY","OTHERS","TOTAL_VOTE")
election$ELECTORAL_VOTE<-as.numeric(as.character(election$ELECTORAL_VOTE))
election$POPULAR_VOTE<-as.numeric(as.character(election$POPULAR_VOTE))

election$TOTAL_VOTE<-as.numeric(gsub(",","",election$TOTAL_VOTE))
election$OBAMA<-as.numeric(gsub(",","",election$OBAMA))
election$ROMNEY<-as.numeric(gsub(",","",election$ROMNEY))
election$OTHERS<-as.numeric(gsub(",","",election$OTHERS))

#New data frame
state<-election$STATE
df_obama<-data.frame(election$STATE,election$OBAMA)
colnames(df_obama)<-c("State","Obama")
df_romney<-data.frame(election$STATE,election$ROMNEY)
colnames(df_romney)<-c("State","Romney")
df_others<-data.frame(election$STATE,election$OTHERS)
colnames(df_others)<-c("State","Others")

newdata<-bind_rows(df_obama,df_romney,df_others)
newdata<-newdata[order(newdata$State),]
newdata$Obama[is.na(newdata$Obama)]<-0
newdata$Romney[is.na(newdata$Romney)]<-0
newdata$Others[is.na(newdata$Others)]<-0

newcol<-as.numeric(newdata$Obama)+as.numeric(newdata$Romney)+as.numeric(newdata$Others)
newdata$combined<-newcol
newdata<-newdata[,-2:-4]
colnames(newdata)<-c("STATE","Combined")
election_2012<-merge(x=newdata,y=election,by.x ='STATE',by.y='STATE')
Candidates<-c("Obama","Romney","Others")
election_re<-data.frame(Candidates,newdata)
colnames(election_re)<-c("Candidates","STATE","Combined")
#Plot
gg <- ggplot(election_re, aes(x=STATE))
gg<-gg+geom_bar(aes(weight=Combined))
gg<-gg+geom_bar(aes(weight=Combined,fill=Candidates))+coord_flip()
gg<-gg+labs(title="2012 U.S Election Vote By State",
            x="State",
            y="Vote Count",
            colour="Candidates")+scale_y_continuous()
gg<-gg+scale_fill_manual(values=c("#3399ff", "#ffd480","#ff6666"))
gg

