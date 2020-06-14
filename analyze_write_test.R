# Combine all benchmark data (CSV, JSON, Redis and Mongo)
#
# input:  btotredis
#         btotmongo
#
# output: banalysis
#

#install.packages("tidyverse")
library(tidyverse)
#install.packages("corrplot")
library(corrplot)
source("http://www.sthda.com/upload/rquery_cormat.r")

btotredis
btotmongo

an <- cbind(btotredis[,c(3,4,5,6,7,8,9,11,12,13,14,15,16,17)],btotmongo[,c(10,11,12)])
an


mydata <- an[, c(3,4,5,9,12,13,15,16)]
rquery.cormat(mydata)

speeds <- rbind(round(an$rwspeedmb, digits=2),round(an$mwspeedmb,digits=2))
colnames(speeds) <- an$dataset

rownames(speeds) <- c("Redis","Mongo")
speeds



currwd <- getwd()
setwd("~/machinelearning/reports")
remove.packages("rJava")
install.packages("rJava")
install.packages("xlsx")
library(xlsx)
write.xlsx(df_info, "df_info.xlsx") 
write.xlsx(json_info, "json_info.xlsx") 
write.xlsx(btotredis, "btotredis.xlsx") 
write.xlsx(btotmongo, "dtotmongo.xlsx") 

# clean up
rm(currwd, an, mydata)

