#
# Doel: ophalen data uit Redis
#
# Nick Bakker
#


library(jsonlite)
library(rredis)

r = redisConnect(host='localhost', port=6379)

json_movies = toJSON(movies2)
redisSet('movies_redis', json_movies)

redisClose()

