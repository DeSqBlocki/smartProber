#!/bin/bash
disks='' #example: 'sda sdb'
sctl=$(which smartctl)
dir=/root/Logs # Logging Directory
date=$(date +"%d-%m-%Y")
file=$dir/$date.log # Log File Syntax
TO= # Mail Recipient
FROM= # Mail Sender

for disk in $disks
do
        echo "[/dev/$disk]:" >> $file # save locally
        echo "ID# ATTRIBUTE_NAME          FLAG     VALUE WORST THRESH TYPE      UPDATED  WHEN_FAILED RAW_VALUE" >> $file # SMART value headers
        $sctl -a /dev/$disk | grep "   0x00" | grep -v capabilities>> $file # should only return SMART values
        echo "" >> $file # line break for clarity
        echo "Num  Test_Description    Status                  Remaining  LifeTime(hours)  LBA_of_first_error" >> $file # SMART test headers
        $sctl -a /dev/$disk | grep "Extended offline" | head -1 >> $file # gets latest 'Extended offline' test result
        echo "" >> $file # line break for clarity
done
column -t $file >> /dev/null # make it look better, and mute output
s-nail -s "SMART Results from $date" -a $file -r $FROM $TO < /dev/null
