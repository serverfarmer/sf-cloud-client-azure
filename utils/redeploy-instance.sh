#!/bin/sh

if [ "$1" = "" ]; then
	echo "usage: $0 <instance-name>"
	exit 1
fi

name=$1
group=`/opt/farm/ext/cloud-client-azure/utils/get-group-name.sh`

az vm redeploy --resource-group $group --name $name --output json
