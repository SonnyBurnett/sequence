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

# Benchmark writing the dataframes 10 times to Redis

b1 <- benchmark(redisSet('blackjack', bj),replications = 10)
b2 <- benchmark(redisSet('covid', cv), replications = 10)
b3 <- benchmark(redisSet('fake', fk), replications = 10)
b4 <- benchmark(redisSet('fifa', ff), replications = 10)
b5 <- benchmark(redisSet('football', fb), replications = 10)
b6 <- benchmark(redisSet('movies', mv), replications = 10)
b7 <- benchmark(redisSet('spotify', sf), replications = 10)
b8 <- benchmark(redisSet('true', tr), replications = 10)
b9 <- benchmark(redisSet('wine', wn), replications = 10)


# bringing it all together.
# Note that we upload a JSON object, not the original data-frame

ballr <- rbind(b1,b2,b3,b4,b5,b6,b7,b8,b9)
ballr <- ballr[,c(1,3)]
names(ballr)[2] <- "rwtime10"
btotredis <- cbind(ballr, df_info, json_info)

btotredis <- transform(btotredis, rwtime =  rwtime10 / 10)
btotredis <- transform(btotredis, rwspeedbt = json_size/rwtime)
btotredis <- transform(btotredis, rwspeedmb = sizemb/rwtime)
btotredis


# Close the connection to the Redis database

redisClose()
