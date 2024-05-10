#!/usr/bin/env bash

vocab_array=()
need_add='true'
index=1

cat '/Users/zhihu/Desktop/vocabulary.log' | while read line
do
if [[ "$line" =~ "(" ]]
then
    if [[ $need_add == 'true' ]]
    then
        echo `echo "$line" | awk -F '[(]' '{print($1)}'`
    fi
else
    if [[ "${vocab_array[@]}" =~ "$line" ]]
    then
        need_add='false'
        continue
    else
        echo "$index"">" `echo "${line}" | awk '{gsub(" /", " [");print $0}' | awk '{gsub("/ ", "] ");print $0}' | awk '{print($1" ("$3") "$2)}'`
        vocab_array+=("$line")
        need_add='true'
        index=`echo "$index+1" | bc`
    fi
fi
done