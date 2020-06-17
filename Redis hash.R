#
# Hashing with Redis

redisClose()
redisConnect()
redisFlushAll()

redisHMSet(toString(movies[,2]),
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

redisInfo()

dfr <- redisHGetAll(toString(movies[,2]))
df <- data.frame(dfr)
dim(df)
head(df)


