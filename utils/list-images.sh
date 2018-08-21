#!/bin/sh
. /etc/local/.cloud/azure/default.sh

file=/root/.azure/skus.$AZURE_REGION.$AZURE_PUBLISHER.$AZURE_OFFER.cache

if [ ! -s $file ] || [ `stat -c %Y $file` -le `date -d '-4 hours' +%s` ]; then
	az vm image list-skus --publisher $AZURE_PUBLISHER --offer $AZURE_OFFER --location $AZURE_REGION >$file
fi

if [ "$1" = "--full" ]; then
	cat $file
else
	grep '"name"' $file |awk '{ print $2 }' |sed -e s/\"//g -e s/,//g |sort
fi
