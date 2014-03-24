#!/bin/sh

cat lorem.txt | tr [:upper:] [:lower:] | sed -E 's/[^[:alpha:]]+/\n/g' | sort | uniq -c | awk '{ print($2,"\t",$1) }'

