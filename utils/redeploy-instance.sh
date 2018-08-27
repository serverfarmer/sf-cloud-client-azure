#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <region> <instance-name>"
	exit 1
fi

region=$1
name=$2
group=`/opt/farm/ext/cloud-client-azure/utils/get-group-name.sh $region`

az vm redeploy --resource-group $group --name $name --output json
