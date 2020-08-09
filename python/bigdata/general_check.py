import requests
import json
import logging
from pyspark.shell import spark
from pyspark.sql import SparkSession, Row
import socket
import sys
import datetime
import os
import pandas as pd
import glob
import os
from hdfs import Config



current_ts = datetime.datetime.now().strftime("%Y-%m-%d_%H:%M:$S")
logger= logging.getLogger('spark_convert_avro_to_orc_count')

try:
    with open('config.json') as f:
        data = json.load(f)
        consul_base_address = "https://" + data['consul-address'] + ".atradiusnet.com:8500"
        consul_host = data["consul-address"]
        consul_token = data["consul-token"]
except IOError as e:
    logger.error("config.json opening error")
    logger.error(os.strerror(e.errno))
    raise Exception("Config file not found")


def setup_logging(loglevel, current_ts):
    """Setup logging"""
    logger.setLevel(loglevel)
    log_filename = "darrensLog--" + current_ts + ".log"
    ch = logging.FileHandler(log_filename, mode='w', encoding='UTF-8')
    ch.setLevel(loglevel)
    formatter = logging.Formatter('%(asctime)s - %(name)s - %(levelname)s - %(threadName)s - %(message)s')
    ch.setFormatter(formatter)
    logger.addHandler(ch)
    return log_filename


def get_ip_address():
    s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    s.connect(('8.8.8.8', port))
    return s.getsockname()[0]


def get_service(service_name):
    """Return the first section of the URL (address and port) for a given fraud microservice."""
    returner = ""
    logger.info("get_service url: " + consul_base_address + "/v1/catalog/service/" + "symhr.service" + "?tag=symd.atradiusnet.com")
    try:
        service = requests.get(consul_base_address + "/v1/catalog/service/" + "symhr.service" + "?tag=symd.atradiusnet.com",
                        headers={"X-Consul-Token": consul_token}, verify=False).json()[0]
	returner = "https://" + service['ServiceAddress'] + ":" + str(service['ServicePort'])         
	logger.info("returner: " + returner)
        return "https://" + service['ServiceAddress'] + ":" + str(service['ServicePort'])
    except requests.exceptions.ConnectionError:
        logger.error("There was an issue with connecting to the symhr service")

def get_symd_pk(table_name):
    """
    Pings the symd service, to get the primary key for a given table.
    :param table name
    :return name of the table's primary key
    """
    service_name = "ch.service"
    retrycount = 3
    counter = 0
    url = get_service(service_name) + "/api/pk/TBBU_POLICIES"
    logger.info("requesting: " + url)
    company_data = requests.get(url, headers= {"X-Consul-Token": consul_token}, verify=False).json()
    logger.info("Company data below")
    logger.info(company_data)
    logger.info("Trying to get just the result")
    logger.info(company_data["result"])
    if "ch_company_files" in company_data and "ch_company_overview" in company_data:
        logger.info(company_data)
    else:
        if retrycount == counter:
           logger.error("counter was hit when making the request..")
        else:
            counter += 1
    #except Exception as e:
    #    logger.error("Exception happened when making the request!!")


def get_symd_data(table_name):
    """Pings the symd servicee, to get 10 records from a given table.
    :param table name to be queried
    :return result: the data of the 10 records
            columnNames: the columns that corrospond to the data in 'result'
    """
    service_name = "ch.service"
    retrycount = 3
    counter = 0 
    url = get_service(service_name) + "/api/ten/TBBU_POLICIES"
    logger.info("requesting: " + url)
    response = requests.get(url, headers= {"X-Consul-Token": consul_token}, verify=False).json()
    data = response["result"]
    column_headers = response["columnNames"]
    logger.info(len(column_headers))    
    n = 1
    dataRow = Row(column_headers)
    for row in data:
        for idx, datapoint in enumerate(row):
            if datapoint is None:
                row[idx] = "Null"
    logger.info(data)
    df = pd.DataFrame(data, columns=column_headers)
    logger.info(df)
    logger.info(df["ID"])
    return df
    


def get_landing_zone_data(table_name):
    """Goes to the landing zone and gets the required data for the given table"""
    lz_path = "/DATA/LZ/SOURCE/SYNC/SYMPHONY/ORABUP0/" + table_name
    logger.info(lz_path)
    #list_of_files = glob.glob(lz_path)
    #print(list_of_files)
    #latest_file = max(list_of_files, key=os.path.getctime)
    #print(latest_file)     
        #latest_file = max(list_of_files, key=os.path.getctime)
    spark = SparkSession.builder \
        .appName("spark_job running for spark_convert_avro_to_orc_incr_count ") \
        .getOrCreate()
    hadoop= spark._jvm.org.apache.hadoop
    fs = hadoop.fs.FileSystem
    conf = hadoop.conf.Configuration() 
    path = hadoop.fs.Path(lz_path)
    logger.info("before for loop")
    
    #'Latest' file is collected based on the most recent 'last modified time' (best i could do rn)
    maxModifyTime = 0    
    for i in fs.get(conf).listStatus(path):
        if i.getModificationTime() > maxModifyTime:
            lastModifiedFile = i
            maxModifyTime = i.getModificationTime()
    logger.info(str(lastModifiedFile.getPath()))
    
    file_path = str(lastModifiedFile.getPath()).replace('hdfs://AtradiusProdCluster1', '')
    logger.info("file_oath below")
    logger.info(file_path)
    #file_path = "/DATA/LZ/SOURCE/SYNC/SYMPHONY/ORABUP0/TBBU_POLICIES/TBBU_POLICIES_*.avro"
    df_avro = spark.read.format("com.databricks.spark.avro").load(file_path) 
    logger.info(df_avro.count())
   

logger.info(sys.version)
log_file_name = setup_logging("DEBUG", current_ts)
logger.info(log_file_name)
#get_isymd_pk("01870434")
#get_symd_data("ptoato")
get_landing_zone_data("TBBU_POLICIES")

