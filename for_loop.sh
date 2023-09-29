#/bin/bash!

for ip in $(cat /tmp/apigwi-ip);do echo $ip; ssh $ip 'find /var/lib/fluentd/intranet/cd1/tenant/ -mmin +60 -type f -name "*.log*" -exec rm -f {} \;'; done 
