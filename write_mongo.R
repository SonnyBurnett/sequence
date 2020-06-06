#
# Doel: opslaan data in Mongo DB.
#
# Nick Bakker
#

# Installeer en activeer benodigde packages
require("mongolite")
library(mongolite)


# Maak een connectie met de Mongo DB
mcon <- mongo(collection="movies2",db="kaggle",url="mongodb://localhost")

# Maak de database leeg
mcon$remove('{}')
mcon$count()

# Voeg alle reviews toe aan de MongoDB
mcon$insert(movies)
mcon$count()

# Sluit de connectie met de Mongo DB
mcon$disconnect()
