# Read the CSV files and put them in dataframes
#
# Input:  9 csv files in a data directory
# Output: 9 csv files loaded in 9 dataframes
#         df_info dataframe with general information
#

currwd <- getwd()
setwd("~/machinelearning/data")

c1 <- benchmark(movies <- read.csv(file="movies.csv"),replications = 1)
c2 <- benchmark(blackjack <- read.csv(file="blackjack.csv"),replications = 1)
c3 <- benchmark(covid <- read.csv(file="covid.csv"),replications = 1)
c4 <- benchmark(fake <- read.csv(file="fake.csv"),replications = 1)
c5 <- benchmark(true <- read.csv(file="true.csv"),replications = 1)
c6 <- benchmark(fifa <- read.csv(file="fifa.csv"),replications = 1)
c7 <- benchmark(football <- read.csv(file="football.csv"),replications = 1)
c8 <- benchmark(spotify <- read.csv(file="spotify.csv"),replications = 1)
c9 <- benchmark(wine <- read.csv(file="wine.csv"),replications = 1)

time_csv <- rbind(c1,c2,c3,c4,c5,c6,c7,c8,c9)
time_csv <- time_csv[,c(1,3)]
names(time_csv)[2] <- "Time_CSV"

# Add general data about the datasets

dataset <- c("blackjack", "covid", "fake", "fifa", 
             "football", "movies", "spotify", "true", "wine")
df_rows <- c(nrow(blackjack), nrow(covid), nrow(fake), nrow(fifa), 
             nrow(football), nrow(movies), nrow(spotify), nrow(true), nrow(wine))
df_cols <- c(ncol(blackjack), ncol(covid), ncol(fake), ncol(fifa), 
             ncol(football), ncol(movies), ncol(spotify), ncol(true), ncol(wine))
df_size <- c(object.size(blackjack), 
             object.size(covid), 
             object.size(fake),
             object.size(fifa), 
             object.size(football), 
             object.size(movies), 
             object.size(spotify), 
             object.size(true), 
             object.size(wine))
df_info <- cbind(dataset, time_csv[2], df_rows, df_cols, df_size)
df_info <- transform(df_info, df_sizekb = round(df_size/1024, digits = 2))
df_info <- transform(df_info, df_sizemb = round(df_sizekb/1024, digits = 2))

# Clean up
setwd(currwd)
rm(c1,c2,c3,c4,c5,c6,c7,c8,c9,dataset, time_csv, df_rows, df_cols, df_size, currwd)