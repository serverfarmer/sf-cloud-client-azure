#!/bin/sh
. /etc/local/.cloud/azure/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <region>"
	exit 1
fi

region=$1
echo farm_$region
