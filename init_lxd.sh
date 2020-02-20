#!/bin/bash

# Preflight check if lxd is already up and running
if [ -e /var/run/snapd/lock/lxd.lock ]; then
	echo "LXD running. Stopping service."
	systemctl stop snap.lxd.socket.service
	systemctl stop snap.lxd.daemon.service
fi
# Run the lxd init
cat <<EOF | /snap/bin/lxd init --preseed
config: {}
networks:
- config:
  ipv4.address: 10.177.2.1/24
  ipv4.nat: "true"
  ipv6.address: none
  description: ""
  managed: false
  name: lxcbr0
  type: ""
storage_pools:
- config:
    size: 2GB
  description: ""
  name: default
  driver: btrfs
profiles:
- config: {}
  description: ""
  devices:
    eth0:
      name: eth0
      nictype: bridged
      parent: lxcbr0
      type: nic
    root:
      path: /
      pool: default
      type: disk
  name: default
cluster: null
EOF
touch /root/.lxd_init
systemctl start snap.lxd.daemon.service
systemctl start snap.lxd.socket.service
