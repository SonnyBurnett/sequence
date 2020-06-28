library(ggplot2)
library(dplyr)
install.packages("stats")
library(stats)
install.packages("animation")	

df <- fifa[1:50,c(56,88)]

ggplot(df, aes(x = Finishing, y = GKReflexes)) +
  geom_point()

fifa_small <- fifa[1:100,c(56,88)] 
kmeans(fifa_small, 3)

set.seed(2345)
library(animation)
kmeans.ani(fifa_small, 3)

