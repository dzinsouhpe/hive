#!/usr/bin/env bash

/usr/local/derby/bin/startNetworkServer -h 127.0.0.1 1>> /tmp/hive/derby-cmd.log 2>> /tmp/hive/derby-cmd.log &
derby_status=$(netstat -an | grep -c "127.0.0.1:1527")

while [ ${derby_status} -le 0 ]
do
    echo "Waiting for Derby database..."
    sleep 1
    derby_status=$(netstat -an | grep -c "127.0.0.1:1527")
done

echo "Derby database started"

schematool --dbType derby --initSchema
echo "Hive Metastore Derby database initialized"

hive --service metastore -v 1>> /tmp/hive/metastore.log 2>> /tmp/hive/metastore.log &
echo "Hive Metastore started"

