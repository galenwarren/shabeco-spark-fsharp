import sys
from pyspark.sql import SparkSession
from pyspark.sql.types import BooleanType
import pyspark.sql.functions as func

APP_NAME = 'Sample'

def aggregate(spark, filename):
    # read the file into spark and name it 'zipcodes'
    spark.read.json(filename).registerTempTable('zipcodes')

    # count the zipcodes by state that meet the custom filter criteria
    agg = spark.sql('select state, count(*) from zipcodes group by state')
    return agg.collect()

if __name__ == "__main__":
    # connect to spark
    spark = SparkSession.builder.appName(APP_NAME).getOrCreate()

    # perform the aggregation and print the results
    print(aggregate(spark, sys.argv[1]))
