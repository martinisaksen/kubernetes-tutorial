#!/bin/bash
# Turn off swap
setenforce 0
sed -i --follow-symlinks 's/SELINUX=enforcing/SELINUX=disabled/g' /etc/sysconfig/selinux
swapoff -a

# Comment out the swap in fstab
sed -i 's+//dev//mapper//centos-swap+# //dev//mapper//centos-swap+g' /etc/fstab

# Turn off firewall
systemctl stop firewalld
systemctl disable firewalld

# Allow Bridge/internet access over nat
modprobe br_netfilter
echo '1' > /proc/sys/net/bridge/bridge-nf-call-iptables
cat /proc/sys/net/bridge/bridge-nf-call-iptables

# Make permanent but editing sysctl.conf and causing br_netfilter to load
echo 'br_netfilter' > /etc/modules-load.d/br_netfilter.conf

cat <<EOF >> /etc/sysctl.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF

echo ''
echo ''
echo '*******************************************'
echo 'Restart server and continue with Setup2.sh'
echo '*******************************************'
echo ''
echo ''