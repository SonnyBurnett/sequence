# benchmark conversion of dataframes to JSON
#
# input:  9 Dataframes loaded
# output: 9 JSON dataframes
#         json_info dataframe with general information
#

j1 <- benchmark(bj <- toJSON(blackjack), replications = 1)
j2 <- benchmark(cv <- toJSON(covid), replications = 1)
j3 <- benchmark(fk <- toJSON(fake), replications = 1)
j4 <- benchmark(ff <- toJSON(fifa), replications = 1)
j5 <- benchmark(fb <- toJSON(football), replications = 1)
j6 <- benchmark(mv <- toJSON(movies), replications = 1)
j7 <- benchmark(sf <- toJSON(spotify), replications = 1)
j8 <- benchmark(tr <- toJSON(true), replications = 1)
j9 <- benchmark(wn <- toJSON(wine), replications = 1)

js <- rbind(j1,j2,j3,j4,j5,j6,j7,j8,j9)
js <- js[,c(1,3)]
names(js)[2] <- "wJSON"
dataset <- c("blackjack", "covid", "fake", "fifa", 
             "football", "movies", "spotify", "true", "wine")
json_size <- c(object.size(bj), 
               object.size(cv), 
               object.size(fk),
               object.size(ff), 
               object.size(fb), 
               object.size(mv), 
               object.size(sf), 
               object.size(tr), 
               object.size(wn))
json_info <- cbind(dataset, js[2], json_size)
json_info <- transform(json_info, json_sizekb = round(json_size/1024, digits = 2))
json_info <- transform(json_info, json_sizemb = round(json_sizekb/1024, digits = 2))
json_info <- transform(json_info, json_wspeed = round(json_sizemb/wJSON, digits = 2))


# Clean up
rm(j1,j2,j3,j4,j5,j6,j7,j8,j9,dataset, js, json_size)
