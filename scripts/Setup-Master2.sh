#!/bin/bash
# Run as regular user
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get pods -o wide --all-namespaces

# Patch kube-proxy DaemonSet to target Linux only
kubectl get ds/kube-proxy -o go-template='{{.spec.updateStrategy.type}}{{"\n"}}' --namespace=kube-system

# Create a file to store node selector
echo 'spec:
  template:
    spec:
      nodeSelector:
        beta.kubernetes.io/os: linux' > node-selector-patch.yml

# Patch the damon setls
kubectl patch ds/kube-proxy --patch "$(cat node-selector-patch.yml)" -n=kube-system

# Enable bridged IPv4 traffic
sudo sysctl net.bridge.bridge-nf-call-iptables=1

# Get Flannel
wget https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml

# Change VXLAN to Host-GW for Windows
sed 's/vxlan/host-gw/' -i kube-flannel.yml

kubectl apply -f kube-flannel.yml

# Apply the patch to the Flannel Network
kubectl patch ds/kube-flannel-ds-amd64 --patch "$(cat node-selector-patch.yml)" -n=kube-system

# Install Dashboard
sh ./InstallDashboard.sh

echo ''
echo ''
echo '*******************************************'
echo 'Switch to JoinNode.sh for Node in # prompt (root)'
echo '*******************************************'
echo ''
echo ''