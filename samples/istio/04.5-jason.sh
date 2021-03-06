#!/bin/bash
if [ "$ISTIO_DIR" = "" ]; then
    echo 'ISTIO_DIR environment is not set. Example: /home/kubeuser/istio-1.0.5'
    exit
fi

echo 'Shift All traffic to V3 for Jason'

cat $ISTIO_DIR/samples/bookinfo/networking/virtual-service-reviews-jason-v2-v3.yaml
kubectl apply -f $ISTIO_DIR/samples/bookinfo/networking/virtual-service-reviews-jason-v2-v3.yaml

