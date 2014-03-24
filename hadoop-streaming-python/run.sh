#!/bin/sh

#check if lorem.txt is on hdfs
../data/beam2hdfs.sh

#set output
HADOOP_OUTPUT_DIR=wordcount-mapreduce-java-output

# cleanup output
$HADOOP_HOME/bin/hadoop fs -rm -r $HADOOP_OUTPUT_DIR
#execute it

$HADOOP_HOME/bin/hadoop jar $HADOOP_HOME/share/hadoop/tools/lib/hadoop-streaming-2.3.0.jar -mapper ./mapper.py -reducer ./reducer.py -input wordcount-input -output $HADOOP_OUTPUT_DIR

#print the output
hadoop fs -cat "$HADOOP_OUTPUT_DIR/*"
