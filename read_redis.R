#
# Doel: opslaan data in Redis
#
# Nick Bakker
#


library(jsonlite)
library(rredis)

redisConnect()

movies3 = fromJSON(redisGet('movies_redis'))
head(movies3)

redisClose()
