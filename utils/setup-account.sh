#!/bin/sh
. /opt/farm/scripts/functions.dialog

if [ "$1" != "default" ]; then
	echo "error: multiple accounts are not supported by Microsoft Azure provider"
	exit 1
fi

if [ "`az account list |grep Enabled`" = "" ]; then
	az login
fi

if [ -f /etc/local/.cloud/azure/default.sh ]; then
	exit 0
fi

REGION="`input \"enter azure region to use\" eastus`"
DEFAULT_INSTANCE_TYPE="`input \"enter azure default instance type\" Standard_A2`"

mkdir -p /etc/local/.cloud/azure
echo "#!/bin/sh
#
# Azure requires \"az\" command line client (Azure 2.0). This tool, as
# opposite to version 1.0, supports only one configured Azure account.
#
############################################################################
#
# Default region to use:
#
export AZURE_REGION=$REGION
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
