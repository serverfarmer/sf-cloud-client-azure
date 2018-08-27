#!/bin/sh
. /etc/local/.cloud/azure/default.sh

if [ "$2" = "" ]; then
	echo "usage: $0 <region> <group-name>"
	exit 1
fi

region=$1
group=$2
list=`/opt/farm/ext/cloud-client-azure/utils/list-groups.sh $region |grep -Fx $group`

if [ "$list" = "" ]; then
	az group create -l $region -n $group
	rm -f /root/.azure/groups.$region.cache
fi
