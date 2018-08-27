#!/bin/sh
. /etc/local/.cloud/azure/default.sh

osver="18.04"

/opt/farm/ext/cloud-client-azure/utils/list-images.sh |grep -v DAILY |grep $osver |tail -n1
