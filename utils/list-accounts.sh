#!/bin/sh

if [ "`az account list |grep Enabled`" != "" ]; then
	/opt/farm/ext/cloud-client-azure/utils/list-available-regions.sh
fi
