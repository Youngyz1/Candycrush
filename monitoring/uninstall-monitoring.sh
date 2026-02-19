#!/bin/bash
echo ">>> Removing Prometheus + Grafana..."
helm uninstall prometheus --namespace monitoring
kubectl delete namespace monitoring
echo ">>> Monitoring removed!"
