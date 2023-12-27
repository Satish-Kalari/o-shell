#!/bin/bash

a=$1
if [ $a -eq 10 ]
then
  echo "a is equal to 10"
elif [ $a -gt 10 ]
then
  echo "a is greater than 10"
else
  echo "a is less than 10"
fi
