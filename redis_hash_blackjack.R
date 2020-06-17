#
# Hashing with Redis


install.packages("hiredis")

redisClose()
redisConnect()
redisFlushAll()

redisHMSet(toString(blackjack[,1]),
           list(
             "PlayerNo" = blackjack[,2],   
             "card1" = blackjack[,3],       
             "card2" = blackjack[,4],       
             "card3" = blackjack[,5],       
             "card4" = blackjack[,6],       
             "card5" = blackjack[,7],      
             "sumofcards" = blackjack[,8],  
             "dealcard1" = blackjack[,9],   
             "dealcard2"= blackjack[,10],   
             "dealcard3" = blackjack[,11],   
             "dealcard4" = blackjack[,12],   
             "dealcard5" = blackjack[,13],   
             "sumofdeal" = blackjack[,14],  
             "blkjck" = blackjack[,15],      
             "winloss" = blackjack[,16],     
             "plybustbeat" = blackjack[,17], 
             "dlbustbeat" = blackjack[,18],  
             "plwinamt" = blackjack[,19],   
             "dlwinamt" = blackjack[,20],    
             "ply2cardsum" = blackjack[,21]
           ))



redisInfo()

dfr <- redisHGetAll(toString(blackjack[,1]))
df <- data.frame(dfr)
dim(df)
head(df)


