# zerotier-installer
Simple bash script to install and configure ZeroTier on Ubuntu. This is for demo/PoC use only.

The following variables must be set before running the script:
* `ZTAPI` = ZeroTier API Key
* `ZTNETWORK` = Network to join member node to

If Python/pip is installed and the the environment variable `SLACK_WEBHOOK_URL` is set, this script will post output to slack.

If successful, this will join/authorize the host it is executed on to the ZeroTier network specified. There is no input validation or error checking done. Use at your own risk :smile:
