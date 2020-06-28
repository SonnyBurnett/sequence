library(dplyr)

dim(wine)
wine$price_empty <- ifelse(as.character(wine$price) == "", "Y", "N")
wine2 <- subset(wine,wine$price_empty == "N")
wine2$points_empty <- ifelse(as.character(wine2$points) == "", "Y", "N")
wine3 <- subset(wine2,wine2$price_empty == "N")
dim(wine3)

set.seed(1000)
test_wine <- sample_n(wine3, 100)
dim(test_wine)

#Load Train and Test datasets
#Identify feature and response variable(s) and values must be numeric and numpy arrays
x_train <- wine3$points
y_train <- wine3$price
x_test <- test_wine[,c(5,6)]

colnames(x_test) <- c("points","price")
x <- wine3[,c(5,6)]
colnames(x) <- c("points","price")

# Train the model using the training sets and check score
linear <- lm(y_train ~ ., data = x)
summary(linear)
prediction <- predict(linear,x_test)
prediction

scatter.smooth(x=wine3$points, y=wine3$price, main="points ~ price")
