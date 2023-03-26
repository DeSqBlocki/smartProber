# smartProber

### doSmart.sh
starts the task of smartctl -t long for each device

### readSmart.sh
sends results of smartctl to chosen mail and logs them locally

### recommended cron config:

0 0 * * SUN /bin/bash -c "/root/doSmart.sh"

0 6 * * SUN /bin/bash -c "/root/readSmart.sh"
