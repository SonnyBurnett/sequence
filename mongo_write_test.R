# Write benchmark test on Mongo database
#
# input:  9 dataframes
#         df_info     - general info on dataframes
#
# output: dataframes stored in redis database
#         btotmongo   - benchmark information 
#

# Prepare each Mongo database by opening and deleting it
# To start completely fresh!

mcon <- mongo(collection="covid",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m2 <- benchmark(mcon$insert(covid),replications = 10)
mcon$disconnect()

mcon <- mongo(collection="fake",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m3 <- benchmark(mcon$insert(fake),replications = 10)
mcon$disconnect()

mcon <- mongo(collection="fifa",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m4 <- benchmark(mcon$insert(fifa),replications = 10)
mcon$disconnect()

mcon <- mongo(collection="football",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m5 <- benchmark(mcon$insert(football),replications = 10)
mcon$disconnect()

mcon <- mongo(collection="movies",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m6 <- benchmark(mcon$insert(movies),replications = 10)
mcon$disconnect()

mcon <- mongo(collection="spotify",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m7 <- benchmark(mcon$insert(spotify),replications = 10)
mcon$disconnect()

mcon <- mongo(collection="true",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m8 <- benchmark(mcon$insert(true),replications = 10)
mcon$disconnect()

mcon <- mongo(collection="wine",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m9 <- benchmark(mcon$insert(wine),replications = 10)
mcon$disconnect()

# Collect the benchmark data of MongoDB

btotmongo <- rbind(m1,m2,m3,m4,m5,m6,m7,m8,m9)
btotmongo <- btotmongo[,c(1,3)]
names(btotmongo)[2] <- "mwtime10"
btotmongo <- transform(btotmongo, mwtime =  mwtime10 / 10)
btotmongo <- cbind(btotmongo,dataset, df_rows, df_cols, df_size, json_size)
btotmongo <- transform(btotmongo, mwspeedbt = df_size/mwtime)
btotmongo <- transform(btotmongo, sizekb = df_size/1024)
btotmongo <- transform(btotmongo, sizemb = sizekb/1024)
btotmongo <- transform(btotmongo, mwspeedmb = sizemb/mwtime)
btotmongo