#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <instance-name> <port>"
	exit 1
fi

name=$1
port=$2
group=`/opt/farm/ext/cloud-client-azure/utils/get-group-name.sh`

az vm open-port --resource-group $group --name $name --port $port --output json
