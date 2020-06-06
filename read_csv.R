#
# Doel: Lees een CSV bestand in
#
# Nick Bakker
#


# Zet de juiste directory
getwd()
setwd("~/machinelearning/data")
getwd()


# Ophalen CSV bestand
movies <- read.csv(file="movies.csv")
dim(movies)
colnames(movies)
