#!/bin/bash
if [ $# -ne 4 ]; then
   echo "not enough arguments";
   exit 0
fi

mm=0
mk=0
km=0
kk=0

for file in ./$4/*.wav;
do  
    ((count++))
    output="$(python3 "$2" "$file")"
    echo "processing file $file"
    echo $output
    gender=${file:12:1}
    if [ "$output" == "$gender" ]; then
        if [ "$gender" == "K" ]; then
            ((kk++))
        else
            ((mm++))
        fi
    else
        if [ "$gender" == "K" ]; then
            ((mk++))
        else
            ((km++))
        fi
    fi
done

echo -e "Done\n\nConfusion matrix:"
echo "    M    K"
echo "M   $mm   $mk"
echo "K   $km   $kk"
echo -e "\nAccuracy: \c"
echo "scale=2; ($mm + $kk) / ($mm + $mk + $km + $kk)" | bc