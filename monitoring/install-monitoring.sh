#!/bin/bash

echo ">>> Installing Helm..."
curl https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3 | bash

echo ">>> Adding Helm repos..."
helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update

echo ">>> Creating monitoring namespace..."
kubectl create namespace monitoring

echo ">>> Installing Prometheus + Grafana..."
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  -f prometheus-values.yml

echo ">>> Waiting for pods to start..."
kubectl wait --for=condition=ready pod \
  -l app.kubernetes.io/name=grafana \
  -n monitoring \
  --timeout=300s

echo ">>> Getting Grafana password..."
kubectl get secret --namespace monitoring prometheus-grafana \
  -o jsonpath="{.data.admin-password}" | base64 --decode ; echo

echo ">>> Services..."
kubectl get svc -n monitoring
