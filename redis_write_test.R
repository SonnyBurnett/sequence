# Write benchmark test on Redis database
#
# input:  9 JSON dataframes
#         json_info   - general info on JSON objects
#         df_info     - general info on dataframes
#
# output: JSON dataframes stored in redis database
#         btotredis   - benchmark information 
#

# Prepare the Redis database by opening and deleting it
# To start completely fresh!

redisClose()
redisConnect()
redisFlushAll()

reps = 1

# Benchmark writing the dataframes 10 times to Redis

b1 <- benchmark(redisSet('blackjack', bj),replications = reps)
b2 <- benchmark(redisSet('covid', cv), replications = reps)
b3 <- benchmark(redisSet('fake', fk), replications = reps)
b4 <- benchmark(redisSet('fifa', ff), replications = reps)
b5 <- benchmark(redisSet('football', fb), replications = reps)
b6 <- benchmark(redisSet('movies', mv), replications = reps)
b7 <- benchmark(redisSet('spotify', sf), replications = reps)
b8 <- benchmark(redisSet('true', tr), replications = reps)
b9 <- benchmark(redisSet('wine', wn), replications = reps)


# bringing it all together.
# Note that we upload a JSON object, not the original data-frame

ballr <- rbind(b1,b2,b3,b4,b5,b6,b7,b8,b9)
ballr <- ballr[,c(1,3)]
names(ballr)[2] <- "rwtimereps"
btotredis <- cbind(ballr, df_info, json_info)

btotredis <- transform(btotredis, rwtime =  rwtimereps / reps)
btotredis <- transform(btotredis, rwspeedbt = round(json_size/rwtime, digits = 2))
btotredis <- transform(btotredis, rwspeedmb = round(json_sizemb/rwtime, digits = 2))


# Close the connection to the Redis database

#redisClose()

# Clean up

rm(b1,b2,b3,b4,b5,b6,b7,b8,b9,ballr)
