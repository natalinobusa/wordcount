#!/bin/sh

#check if lorem.txt is on hdfs
../data/beam2hdfs.sh

#set output
HADOOP_OUTPUT_DIR=wordcount-pig-output

# cleanup output
$HADOOP_HOME/bin/hadoop fs -rm -r $HADOOP_OUTPUT_DIR

#execute it
$PIG_HOME/bin/pig wc.pig

#print the output
hadoop fs -cat "${HADOOP_OUTPUT_DIR}/*"
