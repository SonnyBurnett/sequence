# Read benchmark test on Mongo database
#
# input:  Mongo DB
#
# output: dataframes loaded in R
#         btotreadmongo   - benchmark information 
#

reps = 1

mcon <- mongo(collection="blackjack",db="kaggle",url="mongodb://localhost")
m1 <- benchmark(bj2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="covid",db="kaggle",url="mongodb://localhost")
m2 <- benchmark(cv2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="fake",db="kaggle",url="mongodb://localhost")
m3 <- benchmark(fk2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="fifa",db="kaggle",url="mongodb://localhost")
m4 <- benchmark(ff2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="football",db="kaggle",url="mongodb://localhost")
m5 <- benchmark(fb2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="movies",db="kaggle",url="mongodb://localhost")
m6 <- benchmark(mv2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="spotify",db="kaggle",url="mongodb://localhost")
m7 <- benchmark(sf2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="true",db="kaggle",url="mongodb://localhost")
m8 <- benchmark(tr2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="wine",db="kaggle",url="mongodb://localhost")
m9 <- benchmark(wn2 <- mcon$find('{}'),replications = reps)
mcon$disconnect()

df_size <- c(object.size(bj2), 
             object.size(cv2), 
             object.size(fk2),
             object.size(ff2), 
             object.size(fb2), 
             object.size(mv2), 
             object.size(sf2), 
             object.size(tr2), 
             object.size(wn2))
dataset <- c("blackjack", "covid", "fake", "fifa", 
             "football", "movies", "spotify", "true", "wine")
mdf <- cbind(df_size,dataset)
colnames(mdf) <- c("df_sizeb","dataset")
mdf <- transform(mdf, sizebyte = strtoi(df_sizeb))
mdf <- transform(mdf, df_sizekb = sizebyte / 1024)
mdf <- transform(mdf, df_sizemb = df_sizekb/1024)
mdf

# Collect the benchmark data of MongoDB

btotreadmongo <- rbind(m1,m2,m3,m4,m5,m6,m7,m8,m9)
btotreadmongo <- btotreadmongo[,c(1,3)]
colnames(btotreadmongo)[2] <- "mrtimereps"


btotreadmongo <- transform(btotreadmongo, mrtime =  mrtimereps / reps)
btotreadmongo <- cbind(btotreadmongo, mdf)
btotreadmongo <- btotreadmongo[,c(3,5,8)]
btotreadmongo
colnames(btotreadmongo)[1] <- "mrtime"
btotreadmongo <- transform(btotreadmongo, mrspeedmb = df_sizemb / mrtime)
btotreadmongo

# clean up
rm(m1,m2,m3,m4,m5,m6,m7,m8,m9, mcon, mdf, dataset, df_size)
