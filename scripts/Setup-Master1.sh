#!/bin/bash
# Setup Kubernetes
ipaddr=$(hostname -I | cut -d" " -f 1)
kubeinit=$(kubeadm init --pod-network-cidr=10.244.0.0/16 --apiserver-advertise-address=$ipaddr)

# Save join command to JoinNode script
kubejoincmd=$(grep -F "kubeadm" kubeinit)
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
echo $kubejoincmd >> "{$DIR}JoinNode.sh"

echo ''
echo ''
echo '*******************************************'
echo 'Switch to Setup-Master2.sh for Master in $ prompt (not root)'
echo '*******************************************'
echo ''
echo ''