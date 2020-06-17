import pymongo
import datatable as dt
import pandas as pd
import pprint


myclient = pymongo.MongoClient("mongodb://localhost:27017/")
mydb = myclient["kaggle"]
mycollection = mydb['movies']


mv = dt.fread("../data/movies.csv")
print(mv.head())
print(mv.shape)
print(mv.names)

pf = mv.to_pandas()

data = pf.to_dict(orient='records')
mycollection.insert_many(data)

print(myclient.list_database_names())
print(mydb.list_collection_names())
pprint.pprint(mycollection.find_one({ "Year": 2012 }))
print(mycollection.count_documents({}))
