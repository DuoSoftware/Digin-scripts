#!/bin/bash
#Author - Dasitha Karunajeewa
#Created on - 10.01.2017
#Recomanded to run this in off peak hours to release the hanged SWP memory
echo 3 > /proc/sys/vm/drop_caches && swapoff -a && swapon -a && printf '\n%s\n' 'Ram-cache and Swap Cleared'
