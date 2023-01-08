 #!/bin/bash
disks='sda sdb sdc sdd sde' # add your to-be-monitored devices

for disk in $disks
do
        /usr/sbin/smartctl -t long /dev/$disk
done
