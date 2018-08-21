#!/bin/sh
. /opt/farm/scripts/init

# https://docs.microsoft.com/pl-pl/cli/azure/install-azure-cli-apt?view=azure-cli-latest

KEY="https://packages.microsoft.com/keys/microsoft.asc"
echo "checking for Microsoft Azure repository"

if [ "$OSTYPE" = "redhat" ] && [ ! -f /etc/yum.repos.d/azure-cli.repo ] && grep -qFx $OSVER /opt/farm/ext/cloud-client-azure/config/azcli-system-repo-redhat.conf; then
	echo "setting up Microsoft yum repository"
	rpm --import $KEY
	echo "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=$KEY" >/etc/yum.repos.d/azure-cli.repo

elif [ "$OSTYPE" = "debian" ] && [ ! -f /etc/apt/sources.list.d/azure-cli.list ] && grep -qFx $OSVER /opt/farm/ext/cloud-client-azure/config/azcli-system-repo-debian.conf; then
	echo "setting up Microsoft apt repository"
	REL=`lsb_release -cs`
	echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $REL main" >/etc/apt/sources.list.d/azure-cli.list
	curl -sS -L $KEY |apt-key add -
	/opt/farm/ext/packages/utils/install.sh apt-transport-https
	/opt/farm/ext/packages/utils/refresh.sh
fi

/opt/farm/ext/packages/utils/install.sh azure-cli
