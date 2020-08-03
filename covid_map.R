library(readr)
library(ggplot2)
library(cowplot)

#download.file('https://raw.githubusercontent.com/nytimes/covid-19-data/master/us-counties.csv',dest='us_counties.csv')
dat<-read.csv('us_counties.csv')
head(dat)

us<-aggregate( cases~date,data=dat,FUN=sum)
state<-aggregate( cases~date+state,data=dat,FUN=sum)

#dat<-subset(dat,fips %in% c(36059))
dat2<-subset(dat,state=='Pennsylvania' & county=='Bucks')
dat2<-subset(dat,state=='Maryland'&county=='Montgomery')
dat2$dailyincrease<-numeric(nrow(dat2))
dat2$dailyincrease[1]<-1

for (i in seq(2,nrow(dat2))){
  dat2$dailyincrease[i]<-dat2$cases[i]-dat2$cases[i-1]  
}
#head(subset(dat,state=='New York'&county=='Nassau')) 
gp1<-ggplot(data=dat2,aes(x=date,y=dailyincrease,group=fips))+geom_col()
gp2<-ggplot(data=dat2,aes(x=date,y=cases,group=fips))+geom_line()

plot_grid(gp1,gp2)
