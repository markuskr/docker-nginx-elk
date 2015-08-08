#!/bin/bash

if [ ! -f /home/kibana/logstash.conf ]; then
    echo "File /home/kibana/logstash.conf not found!"
    exit 
fi

/etc/init.d/nginx start
/etc/init.d/rsyslog start
/etc/init.d/crond start

export TERM=linux
export LS_HEAP_SIZE="512m"

/log/elasticsearch-1.6.0/bin/elasticsearch -Xmx1g -Xms1g >> /var/log/itas/elasticsearch &
/log/logstash-1.5.2/bin/logstash -f /home/kibana/logstash.conf >> /var/log/itas/logstash &

/log/kibana-4.1.1-linux-x86/bin/kibana >> /var/log/itas/kibana
