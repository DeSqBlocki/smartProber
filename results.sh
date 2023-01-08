#!/bin/bash
disks='sda sdb sdc sdd sde'
dir=/root/Logs # Logging Directory
date=$(date +"%d-%m-%Y")
file=$dir/$date.log # Log File Syntax
TO=<insert mail here> # Recipient Mail
FROM=<insert mail here> # Sender Mail
for disk in $disks
do
        echo "/dev/$disk" >> $file
        /usr/sbin/smartctl -a /dev/$disk | grep Extended | tail -n 1 >> $file # Gets last line of grep result, i.e. latest results
        echo "" >> $file # line break
done
s-nail -s Report -r $FROM $TO < $file
