#!/bin/bash

#Download Kubernetes Release
curl -L https://git.io/getLatestIstio | sh -
cd ist*

# Add the path of your current directory to your .bashrc
echo 'export PATH=$HOME/istio-1.0.5/bin:$PATH' >> ~/.bashrc
. ~/.bashrc
echo $PATH

#Install Helm
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get > get_helm.sh
chmod 700 get_helm.sh
./get_helm.sh
helm init

# Install Istio with Helm Template
helm template install/kubernetes/helm/istio --name istio --namespace istio-system > $HOME/istio.yaml
kubectl create namespace istio-system
kubectl apply -f $HOME/istio.yaml
kubectl get svc -n istio-system
kubectl get pods -n istio-system -o wide