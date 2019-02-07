#!/bin/bash
# edit the host file. Change with correct IP addresses
echo '
IP_ADDRESS_MASTER kmaster
IP_ADDRESS_NODE1 knode1' >> /etc/hosts

# Setup yum to install kubernetes
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-x86_64
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg
    https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF

yum install -y kubelet kubeadm kubectl docker -y

sed -i 's/cgroup-driver=systemd/cgroup-driver=cgroupfs/g' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

systemctl enable docker && systemctl enable kubelet
systemctl start docker && systemctl start kubelet


echo ''
echo ''
echo '*******************************************'
echo 'Restart server and continue with Setup-Master1.sh for Master'
echo '*******************************************'
echo ''
echo ''