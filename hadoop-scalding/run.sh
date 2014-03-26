#!/bin/sh

#build it
sbt clean assembly

#check if lorem.txt is on hdfs
../data/beam2hdfs.sh

#set output
HADOOP_OUTPUT_DIR=wordcount-mapreduce-scalding-output

# cleanup output
$HADOOP_HOME/bin/hadoop fs -rm -r $HADOOP_OUTPUT_DIR

#execute it
$HADOOP_HOME/bin/hadoop jar target/scala-2.10/wordcount-scalding-assembly-0.8.11.jar WordCount --hdfs --input wordcount-input/lorem.txt --output $HADOOP_OUTPUT_DIR

#print the output
hadoop fs -cat "${HADOOP_OUTPUT_DIR}/*"

