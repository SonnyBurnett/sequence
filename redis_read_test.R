# Benchmarking reading the data from Redis

redisConnect()

# Benchmark reading the dataframe 10 times from Redis

br1 <- benchmark(bj <- redisGet('blackjack'),replications = 10)
br2 <- benchmark(cv <- redisGet('covid'), replications = 10)
br3 <- benchmark(fk <- redisGet('fake'), replications = 10)
br4 <- benchmark(ff <- redisGet('fifa'), replications = 10)
br5 <- benchmark(fb <- redisGet('football'), replications = 10)
br6 <- benchmark(mv <- redisGet('movies'), replications = 10)
br7 <- benchmark(sf <- redisGet('spotify'), replications = 10)
br8 <- benchmark(tr <- redisGet('true'), replications = 10)
br9 <- benchmark(wn <- redisGet('wine'), replications = 10)

redisClose()

brtot <- rbind(br1,br2,br3,br4,br5,br6,br7,br8,br9)
brtot <- brtot[,c(1,3)]
names(brtot)[2] <- "rrtime10"
brtot <- transform(brtot, rrtime =  rrtime10 / 10)
brtot <- cbind(brtot, dataset, df_rows, df_cols, df_size, json_size)
brtot <- transform(brtot, rrspeedbt = json_size/rrtime)
brtot <- transform(brtot, sizekb = json_size/1024)
brtot <- transform(brtot, sizemb = sizekb/1024)
brtot <- transform(brtot, rrspeedmb = sizemb/rrtime)
brtot
