# Combine all benchmark data (CSV, JSON, Redis and Mongo)

btot <-cbind(time_json,btotmongo[,c(2,3)],btotredis[,c(3,4,5,6,7)])
btot