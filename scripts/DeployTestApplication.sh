#!/bin/bash
# Run on Master

cat <<EOF | kubectl apply -f -
apiVersion: v1
kind: Service
metadata:
  name: nginx-server
  namespace: default
  labels:
    app: nginx-server
spec:
  ports:
  - port: 80
    name: http
  selector:
    app: nginx-server
---
apiVersion: extensions/v1beta1
kind: Deployment
metadata:
  name: nginx-http
  namespace: default
spec:
  replicas: 1
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx-server
        image: nginx
        imagePullPolicy: IfNotPresent
        ports:
        - containerPort: 80
EOF

kubectl expose deployment nginx-server --port=80 --name=nginx-http

# Access the CLUSTER-IP in a browser for the nginx-http service
kubectl get service

echo ''
echo ''
echo '*******************************************'
echo 'Access the CLUSTER-IP in a browser for the nginx-http service'
echo '*******************************************'
echo ''
echo ''