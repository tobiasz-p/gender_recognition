#!/bin/bash
if [ $# -ne 4 ]; then
   echo "not enough arguments";
   exit 0
fi

correct=0
count=0

for file in ./$4/*.wav;
do  
    ((count++))
    output="$(python3 "$2" "$file")"
    echo "processing file $file"
    echo $output
    gender=${file:12:1}
    if [ "$output" == "$gender" ]; then
        ((correct++))
    fi
done
echo "scale=2; $correct / $count" | bc