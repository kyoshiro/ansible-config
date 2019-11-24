#!/bin/bash

declare -a StringArray=("jpogran.puppet-vscode" "ms-kubernetes-tools.vscode-kubernetes-tools" "ms-python.python" "redhat.vscode-yaml" "vscoss.vscode-ansible" "yzhang.markdown-all-in-one")

for val in ${StringArray[@]}; do
   sudo -H -u kyoshiro bash -c "code --install-extension $val --force"
done

