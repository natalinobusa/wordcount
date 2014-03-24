#!/bin/sh

#build it
mvn clean package

#check if lorem.txt is on hdfs
../data/beam2hdfs.sh

#set output
HADOOP_OUTPUT_DIR=wordcount-mapreduce-java-output

# cleanup output
$HADOOP_HOME/bin/hadoop fs -rm -r $HADOOP_OUTPUT_DIR

#execute it
$HADOOP_HOME/bin/hadoop jar target/wordcount-mapreduce-java-1.0-SNAPSHOT.jar com.natalinobusa.WordCount wordcount-input $HADOOP_OUTPUT_DIR

#print the output
hadoop fs -cat "${HADOOP_OUTPUT_DIR}/*"
