#!/bin/bash

DISK_USAGE=$(df -hT | grep -vE 'tmp|File')
DISK_THRESHOLD=1 # 1 repesents 1% disk in use only 99% free
message=""

while IFS= read line
do
    usage=$(echo $line | awk '{print $6F}' | cut -d % -f1)
    partition=$(echo $line | awk '{print $1F}')
    if [ $usage -ge $DISK_THRESHOLD ]
    then
        message+="High Disk Usage on $partition: $usage <br>" #<br> html comand for seprate line linke \n in shell
    fi
done <<< $DISK_USAGE

echo -e "Message: $message"

#echo "$message" | mail -s "Hish Disk Usage" sarvag@gmail.com

sh 21-mail.sh "DevOps Team" "High Disk Usage" "$message" "sarvag@gmail.com" "ALERT High Disk Usage"
