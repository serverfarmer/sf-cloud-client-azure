#!/bin/sh
. /etc/local/.cloud/azure/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <ssh-key-name> [instance-type]"
	exit 1
fi

key=$1
pubkey=/etc/local/.ssh/id_azure_$key.pub
random=`date +%s |md5sum |head -c 4`
alias=$key-$random

if [ ! -f $pubkey ]; then
	echo "error: ssh public key for \"$key\" not found"
	exit 0
fi

group=`/opt/farm/ext/cloud-client-azure/utils/get-group-name.sh`
/opt/farm/ext/cloud-client-azure/utils/create-group.sh $group

if [ "$2" != "" ]; then
	type=$2
else
	type=$AZURE_DEFAULT_INSTANCE_TYPE
fi

az vm create \
	--name $alias \
	--size $type \
	--resource-group $group \
	--admin-username ubuntu \
	--public-ip-address-dns-name $alias \
	--location $AZURE_REGION \
	--image $AZURE_PUBLISHER:$AZURE_OFFER:$AZURE_SKU:latest \
	--ssh-key-value $pubkey \
	--output json \
	2>&1 |/opt/farm/ext/cloud-client-azure/internal/parse-create.php

# example output:
# test1-7761.eastus.cloudapp.azure.com running test1 eastus - test1-7761 -
