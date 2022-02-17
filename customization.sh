#!/bin/bash
if [ x$1 = x"precustomization" ]; then
echo "Started doing pre-customization steps..."
echo "Finished doing pre-customization steps."
elif [ x$1 = x"postcustomization" ]; then
echo "Started doing post-customization steps..."
apt update && apt install -y openssh-server jq python3-pip
sudo systemctl enable ssh
export ZTNETWORK=${ztnetwork}
export ZTAPI=${ztapi}
export SLACK_WEBHOOK_URL=${slack_webhook_url}
wget https://raw.githubusercontent.com/shamsway/zerotier-installer/master/zerotier-installer.sh
chmod +x zerotier-installer.sh
echo "Installing and configuring ZeroTier"
./zerotier-installer.sh
rm zerotier-installer.sh
echo "Finished doing post-customization steps."
fi
