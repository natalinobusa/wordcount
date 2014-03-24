#!/bin/sh

#check if the directory exists on hdfs
$HADOOP_HOME/bin/hadoop fs -ls wordcount-input
if  [ $? -ne 0 ] 
  then $HADOOP_HOME/bin/hadoop fs -mkdir wordcount-input/
fi

#check if the lorem.txt exists on hdfs
$HADOOP_HOME/bin/hadoop fs -ls wordcount-input/lorem.txt
if  [ $? -ne 0 ]
  then $HADOOP_HOME/bin/hadoop fs -copyFromLocal lorem.txt wordcount-input/
fi
