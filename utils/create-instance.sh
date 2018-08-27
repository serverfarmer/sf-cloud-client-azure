#!/bin/sh
. /etc/local/.cloud/azure/default.sh

if [ "$2" = "" ]; then
	echo "usage: $0 <region> <ssh-key-name> [instance-type]"
	exit 1
fi

region=$1
key=$2
pubkey=/etc/local/.ssh/id_azure_$key.pub
random=`date +%s |md5sum |head -c 4`
alias=$key-$random

if [ ! -f $pubkey ]; then
	echo "error: ssh public key for \"$key\" not found"
	exit 0
fi

group=`/opt/farm/ext/cloud-client-azure/utils/get-group-name.sh $region`
/opt/farm/ext/cloud-client-azure/utils/create-group.sh $region $group

if [ "$3" != "" ]; then
	type=$3
else
	type=$AZURE_DEFAULT_INSTANCE_TYPE
fi

sku=`/opt/farm/ext/cloud-client-azure/utils/get-ubuntu-image.sh $region`

az vm create \
	--name $alias \
	--size $type \
	--resource-group $group \
	--admin-username ubuntu \
	--public-ip-address-dns-name $alias \
	--location $region \
	--image $AZURE_PUBLISHER:$AZURE_OFFER:$sku:latest \
	--ssh-key-value $pubkey \
	--output json \
	2>&1 |/opt/farm/ext/cloud-client-azure/internal/parse-create.php

# example output:
# test1-7761.eastus.cloudapp.azure.com running test1 eastus - test1-7761 -
