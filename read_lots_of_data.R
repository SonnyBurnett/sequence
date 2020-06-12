install.packages("rbenchmark")
library(rbenchmark)

setwd("~/machinelearning/data")

movies <- read.csv(file="movies.csv")
blackjack <- read.csv(file="blackjack.csv")
covid <- read.csv(file="covid.csv")
fake <- read.csv(file="fake.csv")
true <- read.csv(file="true.csv")
fifa <- read.csv(file="fifa.csv")
football <- read.csv(file="football.csv")
spotify <- read.csv(file="spotify.csv")
wine <- read.csv(file="wine.csv")

