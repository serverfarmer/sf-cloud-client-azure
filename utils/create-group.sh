#!/bin/sh
. /etc/local/.cloud/azure/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <group-name>"
	exit 1
fi

group=$1
list=`/opt/farm/ext/cloud-client-azure/utils/list-groups.sh |grep -Fx $group`

if [ "$list" = "" ]; then
	az group create -l $AZURE_REGION -n $group
	rm -f /root/.azure/groups.$AZURE_REGION.cache
fi
