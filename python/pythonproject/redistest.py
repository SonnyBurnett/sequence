import redis
import datatable as dt
import time
import json
import pandas as pd


def read_csv_to_json(dataset):
    csv_file = "~/machinelearning/data/" + dataset + ".csv"
    my_list = dt.fread(csv_file)
    pf = my_list.to_pandas()
    data = pf.to_dict(orient='records')
    my_json_string = json.dumps(data)
    return my_json_string


def write_redis_dataset(dataset, rediscon):
    rediscon.flushdb()
    json_data = read_csv_to_json(dataset)
    start_time = time.time()
    rediscon.set(dataset, json_data)
    end_time = time.time()
    return end_time - start_time


def read_redis_dataset(dataset, rediscon):
    start_time = time.time()
    new_json_data = rediscon.get(dataset)
    end_time = time.time()
    new_dict = json.loads(new_json_data)
    new_panda = pd.DataFrame.from_dict(new_dict)
    return end_time - start_time


def print_dataframe(dataframe):
    pd.set_option("display.max_rows", 5, "display.max_columns", None)
    print(dataframe)


redis_con = redis.Redis(host='localhost', port=6379, db=0)
dataset_list = ["blackjack", "covid", "fake", "fifa",
                "football", "movies", "spotify", "true", "wine"]
for d in dataset_list:
    print("write", d, write_redis_dataset(d, redis_con), "seconds")
    print("read ", d, read_redis_dataset(d, redis_con), " seconds")
    print_dataframe(d)
