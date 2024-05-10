#!/usr/bin/env bash

log_file='001'
log_path='/Users/zhihu/person/vacab/'
log=$log_path$log_file".log"
s_index=1
n_index=1
need_add='false'

rm $log_path$log_file"_n.log"
rm $log_path$log_file"_s.log"

while read -u 3 line
do
if [[ "$line" =~ "(" ]]
then
    echo `echo "$line" | awk '{print($1" "$2" "$4)}'`
    read -s res
    l=`echo "${line}" | awk -F '[>]' '{print($(NF))}'`
    if [[ "$res" == "n" ]]
    then
        echo `echo "$line" | awk '{print($3)}'`
        `echo "$n_index"."$l" >> "$log_path""$log_file"_n.log`
        n_index=`echo "$n_index+1" | bc`
        need_add='true'
    else
        `echo "$s_index"."$l" >> "$log_path""$log_file"_s.log`
        s_index=`echo "$s_index+1" | bc`
        need_add='false'
    fi
else
    if [[ $need_add == 'true' ]]
    then
        `echo "$line" >> "$log_path""$log_file"_n.log`
    fi
fi
done 3< ${log}