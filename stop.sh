#!/bin/bash
# nodes
kubectl delete deployment bootnode
kubectl delete service bootnode
kubectl delete deployment clique-testnet-miner1
kubectl delete deployment clique-testnet-miner2
kubectl delete deployment clique-testnet-miner3
# volume and claim
kubectl delete pvc clique-testnet-disk
kubectl delete pv clique-testnet-pv-volume