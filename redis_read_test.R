# Benchmarking reading the data from Redis
#
# input:  Data must be in the Redis database
#         df_info
# Output: 9 JSON datasets in R
#         brtot

redisConnect()

# Benchmark reading the dataframe x times from Redis

reps = 1

br1 <- benchmark(bj <- redisGet('blackjack'),replications = reps)
br2 <- benchmark(cv <- redisGet('covid'), replications = reps)
br3 <- benchmark(fk <- redisGet('fake'), replications = reps)
br4 <- benchmark(ff <- redisGet('fifa'), replications = reps)
br5 <- benchmark(fb <- redisGet('football'), replications = reps)
br6 <- benchmark(mv <- redisGet('movies'), replications = reps)
br7 <- benchmark(sf <- redisGet('spotify'), replications = reps)
br8 <- benchmark(tr <- redisGet('true'), replications = reps)
br9 <- benchmark(wn <- redisGet('wine'), replications = reps)

redisClose()

brtot <- rbind(br1,br2,br3,br4,br5,br6,br7,br8,br9)
brtot <- brtot[,c(1,3)]
colnames(brtot)[2] <- "rrtimereps"
brtot <- transform(brtot, rrtime =  rrtimereps / reps)
brtot <- cbind(brtot[,c(3)], df_info[,c(1,3,4,7)], json_info[,c(3,5)])
colnames(brtot)[1] <- "rrtime"
brtot <- transform(brtot, rrspeedmb = json_sizemb / rrtime)
brtot

# clean up
rm(br1,br2,br3,br4,br5,br6,br7,br8,br9,reps)
