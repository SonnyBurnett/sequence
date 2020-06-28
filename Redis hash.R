#
# Hashing with Redis

library(tidyverse)

redisClose()
redisConnect()

redisFlushAll()
redisHMSet(paste("key",1),
           list("Title" = toString(movies[1,3]),
                "Year" = toString(movies[1,4]),
                "Age" = toString(movies[1,5]),
                "IMDb" = toString(movies[1,6]),        
                "Runtime" = toString(movies[1,17])
           ))
redisHVals("key 1")

redisInfo()

dfr <- redisHGetAll(toString(movies[,2]))
df <- data.frame(dfr)
dim(df)
head(df)

redisHMSet("123456789",
           list("Title" = "Die Hardest of all",
                "Year" = 2022,
                "Age" = -2,
                "IMDb" = 10,        
                "Rotten.Tomatoes" = "100%",
                "Netflix" = 1,
                "Hulu" = 1,
                "Prime.Video" = 1,
                "Disney." = 1,
                "Type" = "good",
                "Directors" = "Mickey Mouse",
                "Genres" = "unique",
                "Country" = "Mozambique",
                "Language" = "Swahili",
                "Runtime" = 2345
           ))
redisHVals("123456789")

redisHMSet("tacobakker",
           list("Title" = movies[,3],
                "Year" = movies[,4],
                "Age" = movies[,5],
                "IMDb" = movies[,6],        
                "Rotten.Tomatoes" = movies[,7],
                "Netflix" = movies[,8],
                "Hulu" = movies[,9],
                "Prime.Video" = movies[,10],
                "Disney." = movies[,11],
                "Type" = movies[,12],
                "Directors" = movies[,13],
                "Genres" = movies[,14],
                "Country" = movies[,15],
                "Language" = movies[,16],
                "Runtime" = movies[,17]
           ))

redisHVals("tacobakker")
