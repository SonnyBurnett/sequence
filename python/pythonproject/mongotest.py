import pymongo
import datatable as dt
import time
import pandas as pd


def open_connection(dataset):
    my_client = pymongo.MongoClient("mongodb://localhost:27017/")
    my_db = my_client["kaggle"]
    my_collection = my_db[dataset]
    my_list = [my_client, my_db, my_collection]
    return my_list


def read_csv_to_panda(dataset):
    csv_file = "~/machinelearning/data/" + dataset + ".csv"
    mv = dt.fread(csv_file)
    pf = mv.to_pandas()
    data = pf.to_dict(orient='records')
    return data


def write_dataset(dataset):
    db_list = open_connection(dataset)
    panda_data = read_csv_to_panda(dataset)
    db_list[2].drop()
    start = time.time()
    db_list[2].insert_many(panda_data)
    ending = time.time()
    db_list[0].close()
    return ending - start


def read_dataset(dataset):
    db_list = open_connection(dataset)
    start = time.time()
    cursor = db_list[2].find({})
    df = pd.DataFrame(list(cursor))
    ending = time.time()
    db_list[0].close()
    return ending - start


dataset_list = ["blackjack", "covid", "fake", "fifa",
             "football", "movies", "spotify", "true", "wine"]
for d in dataset_list:
    print("write", d, write_dataset(d), "seconds")
    print("read ", d, read_dataset(d), " seconds")
