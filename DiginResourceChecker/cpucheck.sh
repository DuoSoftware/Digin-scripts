#!/bin/bash
#Dasitha 10-01-2017
while true; 
do 
(echo "%CPU %MEM ARGS $(date)" && ps -e -o pcpu,pmem,args --sort=pcpu | cut -d" " -f1-5 | tail) >> ps.log; sleep 5; 
done


