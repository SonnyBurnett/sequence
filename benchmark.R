library(jsonlite)
library(rredis)
library(rbenchmark)
library(pryr)
library(mongolite)

setwd("~/machinelearning")

source("read_csv_data.R")
df_info
head(blackjack)
dim(blackjack)
source("convert_df_to_json.R")
json_info

source("redis_write_test.R")
btotredis[,c(2,3,18)]

source("mongo_write_test.R")
btotmongo

source("analyze_write_test.R")
speeds

source("redis_read_test.R")
brtot[,c(1,2,8)]

source("convert_json_to_df.R")
json_read_info

source("mongo_read_test.R")
btotreadmongo

bh <- benchmark(source("redis_hash_blackjack.R"), replications = 1)
bh
