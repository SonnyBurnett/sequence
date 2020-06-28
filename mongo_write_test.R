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
m2 <- benchmark(mcon$insert(covid),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="fake",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m3 <- benchmark(mcon$insert(fake),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="fifa",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m4 <- benchmark(mcon$insert(fifa),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="football",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m5 <- benchmark(mcon$insert(football),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="movies",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m6 <- benchmark(mcon$insert(movies),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="spotify",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m7 <- benchmark(mcon$insert(spotify),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="true",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m8 <- benchmark(mcon$insert(true),replications = reps)
mcon$disconnect()

mcon <- mongo(collection="wine",db="kaggle",url="mongodb://localhost")
mcon$remove('{}')
m9 <- benchmark(mcon$insert(wine),replications = reps)
mcon$disconnect()

# Collect the benchmark data of MongoDB

btotmongo <- rbind(m1,m2,m3,m4,m5,m6,m7,m8,m9)
btotmongo <- btotmongo[,c(1,3)]
names(btotmongo)[2] <- "mwtimereps"
btotmongo <- cbind(btotmongo[2],df_info)
btotmongo <- transform(btotmongo, mwtime =  mwtimereps / reps)
btotmongo <- transform(btotmongo, mwspeedbt = round(df_size/mwtime, digits = 2))
btotmongo <- transform(btotmongo, mwspeedmb = round(df_sizemb/mwtime, digits = 2))

# clean up
rm(m1,m2,m3,m4,m5,m6,m7,m8,m9, mcon)