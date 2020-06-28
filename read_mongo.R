#
# Doel: ophalen data uit Mongo DB.
#
# Nick Bakker
#

# Installeer en activeer benodigde packages
require("mongolite")
library(mongolite)

# Maak een connectie met de Mongo DB
# En haal de data op
mcon <- mongo(collection="movies2",db="kaggle",url="mongodb://localhost")
movies2 <- mcon$find('{ "Year" : 2010 }')
dim(movies2)

colnames(movies)
