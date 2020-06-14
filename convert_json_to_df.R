# benchmark conversion of dataframes to JSON
#
# input:  9 JSON dataframes
# output: 9 dataframes converted
#         json_read_info dataframe with general information
#

reps = 1

j1 <- benchmark(bj1 <- fromJSON(bj), replications = reps)
j2 <- benchmark(cv1 <- fromJSON(cv), replications = reps)
j3 <- benchmark(fk1 <- fromJSON(fk), replications = reps)
j4 <- benchmark(ff1 <- fromJSON(ff), replications = reps)
j5 <- benchmark(fb1 <- fromJSON(fb), replications = reps)
j6 <- benchmark(mv1 <- fromJSON(mv), replications = reps)
j7 <- benchmark(sf1 <- fromJSON(sf), replications = reps)
j8 <- benchmark(tr1 <- fromJSON(tr), replications = reps)
j9 <- benchmark(wn1 <- fromJSON(wn), replications = reps)

js <- rbind(j1,j2,j3,j4,j5,j6,j7,j8,j9)
js <- js[,c(1,3)]
names(js)[2] <- "rJSON"
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
json_read_info <- cbind(dataset, js[2], json_size)
json_read_info <- transform(json_read_info, json_sizekb = round(json_size/1024, digits = 2))
json_read_info <- transform(json_read_info, json_sizemb = round(json_sizekb/1024, digits = 2))
json_read_info <- transform(json_read_info, json_readspeed = round(json_sizemb/rJSON, digits = 2))

# Clean up
rm(j1,j2,j3,j4,j5,j6,j7,j8,j9,dataset, js, json_size)
