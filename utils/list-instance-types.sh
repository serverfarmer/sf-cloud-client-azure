#!/bin/sh
. /etc/local/.cloud/azure/default.sh

if [ "$1" = "" ]; then
	echo "usage: $0 <region>"
	exit 1
fi

region=$1
file=/root/.azure/sizes.$region.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d yesterday +%s` ]; then
	az vm list-sizes -l $region >$file
fi

if [ "$1" = "--full" ]; then
	cat $file
else
	grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort
fi
