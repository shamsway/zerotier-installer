#!/bin/bash

ZT_BASE_URL_HTTPS='https://download.zerotier.com/'
ZT_BASE_URL_HTTP='http://download.zerotier.com/'

ICON_EMOJI=:man-lifting-weights:
HOSTNAME=$(hostname)
LOCALIP=$(ip addr show | grep "inet " | grep -v "127.0.0.1/8" | awk '{print $2}')

if [ -n "$SLACK_WEBHOOK_URL" ]; then
  pip install slack-webhook-cli
  slack -u $HOSTNAME -e $ICON_EMOJI "I'm up! My local ip is $LOCALIP. I'm joining ZeroTier network $ZTNETWORK"
fi
echo Joining Network: $ZTNETWORK

SUDO=
if [ "$UID" != "0" ]; then
	if [ -e /usr/bin/sudo -o -e /bin/sudo ]; then
		SUDO=sudo
	else
		echo '*** This quick installer script requires root privileges.'
		exit 0
	fi
fi

rm -f /tmp/zt-gpg-key
echo '-----BEGIN PGP PUBLIC KEY BLOCK-----' >/tmp/zt-gpg-key
cat >>/tmp/zt-gpg-key << END_OF_KEY
Comment: GPGTools - https://gpgtools.org

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
=JgAv
END_OF_KEY
echo '-----END PGP PUBLIC KEY BLOCK-----' >>/tmp/zt-gpg-key

if [ -f /etc/debian_version ]; then
	dvers=`cat /etc/debian_version | cut -d '.' -f 1 | cut -d '/' -f 1`
	$SUDO rm -f /tmp/zt-sources-list

	if [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F trusty`" ]; then
		# Ubuntu 'trusty'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/trusty trusty main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F wily`" ]; then
		# Ubuntu 'wily'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/wily wily main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F xenial`" ]; then
		# Ubuntu 'xenial'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/xenial xenial main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F zesty`" ]; then
		# Ubuntu 'zesty'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/zesty zesty main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F precise`" ]; then
		# Ubuntu 'precise'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/precise precise main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F artful`" ]; then
		# Ubuntu 'artful'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/artful artful main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F bionic`" ]; then
		# Ubuntu 'bionic'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/bionic bionic main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F yakkety`" ]; then
		# Ubuntu 'yakkety'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/yakkety yakkety main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F disco`" ]; then
		# Ubuntu 'disco'
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/disco disco main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F focal`" ]; then
		# Ubuntu 'focal' -> Ubuntu 'bionic' (for now)
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/bionic bionic main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F hirsute`" ]; then
		# Ubuntu 'hirsute' -> Ubuntu 'bionic' (for now)
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/bionic bionic main" >/tmp/zt-sources-list
	elif [ -f /etc/lsb-release -a -n "`cat /etc/lsb-release 2>/dev/null | grep -F impish`" ]; then
		# Ubuntu 'impish' -> Ubuntu 'bionic' (for now)
		echo '*** Found Ubuntu, creating /etc/apt/sources.list.d/zerotier.list'
		echo "deb ${ZT_BASE_URL_HTTP}debian/bionic bionic main" >/tmp/zt-sources-list
  fi

  $SUDO mv -f /tmp/zt-sources-list /etc/apt/sources.list.d/zerotier.list
  $SUDO chown 0 /etc/apt/sources.list.d/zerotier.list
  $SUDO chgrp 0 /etc/apt/sources.list.d/zerotier.list
  $SUDO apt-key add /tmp/zt-gpg-key
  
  echo
	echo '*** Installing zerotier-one package...'
  
  $SUDO apt-get update
  $SUDO apt-get install -y zerotier-one
  $SUDO rm -f /tmp/zt-gpg-key
fi

$SUDO systemctl enable zerotier-one
$SUDO systemctl start zerotier-one
if [ "$?" != "0" ]; then
  echo
  echo '*** Package installed but cannot start service! You may be in a Docker'
  echo '*** container or using a non-standard init service.'
  echo
  exit 1
fi

echo
echo '*** Waiting for identity generation...'

while [ ! -f /var/lib/zerotier-one/identity.secret ]; do
	sleep 1
done

echo
echo "*** Success! You are ZeroTier address [ `cat /var/lib/zerotier-one/identity.public | cut -d : -f 1` ]."
echo

zerotier-cli join $ZTNETWORK 
#zerotier-cli -j info > zt-info
ZTADDRESS=$(zerotier-cli -j info|jq ".address"| tr -d '"')
if [ -n "$SLACK_WEBHOOK_URL" ]; then slack -u $HOSTNAME -e $ICON_EMOJI "My ZeroTier address is $ZTADDRESS" ; fi
curl -H "Authorization: bearer $ZTAPI" -H "Content-Type: application/json" -X POST -d '{ "config":{ "authorized": true } }' https://my.zerotier.com/api/network/$ZTNETWORK/member/$ZTADDRESS
curl -H "Authorization: bearer $ZTAPI" -H "Content-Type: application/json" -X POST -d '{ "name":"'$(hostname)'" }' https://my.zerotier.com/api/network/$ZTNETWORK/member/$ZTADDRESS
#curl -H "Authorization: bearer $ZTAPI" https://my.zerotier.com/api/network/$ZTNETWORK/member/$ZTADDRESS > zt-member
#ZTIP=$(cat zt-member | jq ".config.ipAssignments" | tr -d '[]" \n')

COUNTER=9

while [  $COUNTER -gt 0 ] && [ -z "$ZTIP" ]; do
  ZTIP=$(zerotier-cli get $ZTNETWORK ip4)
  if [ -n "$ZTIP" ]; then
    if [ -n "$SLACK_WEBHOOK_URL" ]; then slack -u $HOSTNAME -e $ICON_EMOJI "My ZeroTier IP is $ZTIP. VM customization Complete." ; fi
    echo ZeroTier IP: $ZTIP
  fi
  sleep 10
  let COUNTER-=1
done

if [ -z "$ZTIP" ]; then
  if [ -n "$SLACK_WEBHOOK_URL" ]; then slack -u $HOSTNAME -e $ICON_EMOJI "Could not determine ZeroTier IP. VM customization complete." ; fi
fi

#rm zt-info
#rm zt-member

exit 0
