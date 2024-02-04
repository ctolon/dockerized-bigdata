from pyspark.sql import SparkSession
from pyspark.conf import SparkConf
from pyspark import SparkContext
import os

pyspark = SparkSession.builder \
.master("local[2]") \
.appName("Test") \
.config("spark.executor.memory", "3g") \
.config("spark.driver.memory", "2g") \
.getOrCreate()

sc = pyspark.sparkContext

df = pyspark.read.json("response_data.json")
df.printSchema()
