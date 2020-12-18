#!/bin/bash
if [ $# -ne 1 ]; then
   echo "not enough arguments";
   exit 0
fi

correct=0
count=0
dir=$1
for file in ./$1/*.wav;
do  
    ((count++))
    output="$(python3 2.py "$file")"
    echo "processing file $file"
    echo $output
    gender=${file:12:1}
    if [ "$output" == "$gender" ]; then
        ((correct++))
    fi
done

echo "scale=2; $correct / $count" | bc 