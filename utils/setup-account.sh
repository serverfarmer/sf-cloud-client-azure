#!/bin/sh
. /opt/farm/scripts/functions.dialog

if [ "`az account list |grep Enabled`" = "" ]; then
	az login
fi

if [ ! -f /root/.azure/locations.cache ]; then
	az account list-locations >/root/.azure/locations.cache
fi

if [ -f /etc/local/.cloud/azure/default.sh ]; then
	exit 0
fi

DEFAULT_INSTANCE_TYPE="`input \"enter azure default instance type\" Standard_A2`"

mkdir -p /etc/local/.cloud/azure
echo "#!/bin/sh
#
# Azure requires \"az\" command line client (Azure 2.0). This tool, as
# opposite to version 1.0, supports only one configured Azure account.
# But Cloud Farmer treats each Azure region as separate account.
#
############################################################################
#
# Ubuntu publisher and offer keys (mostly you don't need to change them):
#
export AZURE_PUBLISHER=Canonical
export AZURE_OFFER=UbuntuServer
#
# Default instance type to use, when type isn't explicitely specified
# (use list-instance-types.sh script to discover all instance types):
#
export AZURE_DEFAULT_INSTANCE_TYPE=$DEFAULT_INSTANCE_TYPE
" >/etc/local/.cloud/azure/default.sh
chmod 0600 /etc/local/.cloud/azure/default.sh
