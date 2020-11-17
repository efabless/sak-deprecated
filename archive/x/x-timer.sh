#!/bin/bash
x=1000000000000
while [ $x -gt 0 ]
do
sleep 5s
#clear
#echo "$x seconds until blast off"
free -h
x=$(( $x -1))
done
