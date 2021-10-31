#!/bin/bash
# volume and claim
kubectl apply -f pv.yaml
kubectl apply -f pvc.yaml
# nodes
kubectl apply -f bootnode.yaml
kubectl apply -f miners.yaml