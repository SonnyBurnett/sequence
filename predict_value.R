install.packages("caret")
library(caret)
install.packages("stringr")
library(stringr)
library(tidyverse)


players <- fifa[,c(8,9,12)]
players$val1 <- gsub("€","",players$Value)
players$milork <- ifelse(str_sub(players$val1,-1,-1) == "M", "M", "K")
players$val2 <- gsub("M","",players$val1)
players$val2 <- gsub("K","",players$val2)
players$val3 <- as.numeric(players$val2)
players$val4 <- ifelse(players$milork == "M", players$val3*1000, players$val3)
dim(players)

test_players <- players[c(1:1000),c(1,2,8)]
train_players <- players[c(1001:18207),c(1,2,8)]

model <- train(val4 ~ .,
               data = train_players,
               method = "lm")
predict_val <- predict(model, test_players)
compare_value <- cbind(data.frame(predict_val),players$val4[c(1:1000)])
compare_value

###################################

critics <- movies[,c(6,7)]
critics$Rotten.Tomatoes <- replace(as.character(critics$Rotten.Tomatoes), critics$Rotten.Tomatoes == "", "NA")
critics2 <- subset(critics, Rotten.Tomatoes != "NA")
dim(critics2)

dim(critics2)
test_critics <- critics2[c(1:1000),]
train_critics <- critics2[c(1001:5000),]

model <- train(IMDb ~ Rotten.Tomatoes,
               data = critics2,
               method = "lm")

predict_val <- predict(model, train_critics)
predict_val

##############################################

head(wine)
colnames(wine)
soorten <- data.frame(unique(wine$variety))
regios <- data.frame(unique(wine$region_1))
provs <- data.frame(unique(wine$province))
dim(provs)
dim(soorten)
dim(regios)
dim(wine)
head(wine)
