#!/bin/bash

# Preflight check if lxd is already up and running
if [ -e /var/run/snapd/lock/lxd.lock ]; then
	echo "LXD already configured. Skipping."
else
  # Run the lxd init
cat <<EOF | /snap/bin/lxd init --preseed
config: {}
networks:
- config:
    ipv4.address: 10.0.4.1/24
    ipv4.nat: true
    ipv6.address: none
  description: ""
  managed: false
  name: lxdbr0
  type: ""
storage_pools:
- config:
    size: 16GB
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
      parent: lxdbr0
      type: nic
    root:
      path: /
      pool: default
      type: disk
  name: default
cluster: null
EOF
fi
