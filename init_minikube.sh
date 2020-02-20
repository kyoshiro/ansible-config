#!/bin/bash
lxc profile create minikube

cat << EOF | lxc profile edit minicube
name: minikube
config:
  linux.kernel_modules: ip_tables,ip6_tables,netlink_diag,nf_nat,overlay
  raw.lxc: |
    lxc.apparmor_profile=unconfined
    lxc.mount.auto=proc:rw sys:rw
    lxc.cap.drop=
  security.nesting: "true"
  security.privileged: "true"
description: Profile supporting minikube in containers
devices:
  aadisable:
    path: /sys/module/apparmor/parameters/enabled
    source: /dev/null
    type: disk
EOF

lxc launch ubuntu:18.04 minikube
lxc profile apply minikube default,minikube

