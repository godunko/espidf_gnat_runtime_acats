#!/bin/bash

log=$1

total=`cat log | grep ' ,.,.' | wc -l`
passed=`cat log | grep ' ==== [0-9a-zA-Z_]* PASSED' | wc -l`

echo "TOTAL:  $total"
echo "PASSED: $passed"

if [ "$total" = "0" ]; then
  exit 1

elif [ "$total" != "$passed" ]; then
  exit 2
fi
