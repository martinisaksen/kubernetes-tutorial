#!/bin/bash

if [ "$ISTIO_DIR" = "" ]; then
    echo 'ISTIO_DIR environment is not set. Example: /home/kubeuser/istio-1.0.5'
    exit
fi

export SOURCE_POD=$(kubectl get pod -l app=sleep -o jsonpath={.items..metadata.name})

kubectl get serviceentries
kubectl get virtualservices

kubectl delete serviceentry httpbin-ext 
kubectl delete serviceentry google 
kubectl delete serviceentry winiis-ext
kubectl delete virtualservice google

kubectl get serviceentries
kubectl get virtualservices
