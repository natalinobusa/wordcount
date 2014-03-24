#!/bin/sh

#build it (please select your own java 6 jvm home install)
JAVA_HOME=/usr/lib/jvm/java-6-oracle gradle clean jar

#check if lorem.txt is on hdfs
../data/beam2hdfs.sh

#set output
HADOOP_OUTPUT_DIR=wordcount-cascading-output

# cleanup output
$HADOOP_HOME/bin/hadoop fs -rm -r $HADOOP_OUTPUT_DIR

#execute it
$HADOOP_HOME/bin/hadoop jar ./build/libs/wordcount.jar wordcount-input/lorem.txt $HADOOP_OUTPUT_DIR

#print the output
hadoop fs -cat "${HADOOP_OUTPUT_DIR}/*"

