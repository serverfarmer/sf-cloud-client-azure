#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <instance-name> <new-instance-type>"
	exit 1
fi

name=$1
type=$2
group=`/opt/farm/ext/cloud-client-azure/utils/get-group-name.sh`

az vm resize --resource-group $group --name $name --size $type --output json
