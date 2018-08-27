#!/bin/sh
. /etc/local/.cloud/azure/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <region>"
	exit 1
fi

region=$1
osver="18.04"

/opt/farm/ext/cloud-client-azure/utils/list-images.sh $region |grep -v DAILY |grep $osver |tail -n1
