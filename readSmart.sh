#!/bin/bash
disks='' #example: 'sda sdb sdc sdd sde'
sctl=$(which smartctl)
dir=/root/Logs # Logging Directory
date=$(date +"%d-%m-%Y")
file=$dir/$date.log # Log File Syntax
TO= # Mail Recipient
FROM= # Mail Sender

for disk in $disks
do
        echo "[/dev/$disk]:" >> $file # save locally
        $sctl -a /dev/$disk | grep "0x00" | grep -v capabilities >> $file # should only return all SMART values
        echo "" >> $file # line break for clarity
        $sctl -a /dev/$disk | grep "Extended offline" | head -1 >> $file # gets latest 'Extended offline' test result
        echo "" >> $file # line break for clarity
done
s-nail -s Report -r $FROM $TO < $file
