# ÌΩ¨ CandyCrush DevOps Pipeline

A complete end-to-end DevOps pipeline featuring CI/CD automation, security scanning, containerization, Kubernetes deployment on AWS EKS, and monitoring with Prometheus and Grafana.

## ÌøóÔ∏è Architecture
```
GitHub Push ‚Üí GitHub Actions ‚Üí SonarQube ‚Üí Trivy ‚Üí Docker ‚Üí EKS ‚Üí Prometheus + Grafana
```

## Ìª†Ô∏è Tech Stack

| Tool | Purpose |
|------|---------|
| GitHub Actions | CI/CD Pipeline |
| SonarQube | Static Code Analysis |
| Trivy | Security Scanning |
| Docker | Containerization |
| Docker Hub | Container Registry |
| Terraform | Infrastructure as Code |
| AWS EKS | Kubernetes Cluster |
| Prometheus | Metrics Collection |
| Grafana | Monitoring Dashboards |
| Slack | Notifications |

## Ì∫Ä Quick Start

### 1. Install Tools on EC2
```bash
sudo apt-get update
sudo apt install docker.io -y
sudo chmod 777 /var/run/docker.sock
```

### 2. Run SonarQube
```bash
docker run -d --name sonar -p 9000:9000 sonarqube:lts-community
```

### 3. GitHub Secrets Required

| Secret | Description |
|--------|-------------|
| SONAR_TOKEN | SonarQube token |
| SONAR_HOST_URL | http://<EC2-IP>:9000 |
| DOCKERHUB_USERNAME | Docker Hub username |
| DOCKERHUB_TOKEN | Docker Hub access token |
| SLACK_WEBHOOK_URL | Slack webhook URL |

### 4. Deploy EKS with Terraform
```bash
cd Eks-terraform
terraform init
terraform apply --auto-approve
aws eks --region us-east-1 update-kubeconfig --name EKS_CLOUD
```

### 5. Deploy Application
```bash
kubectl apply -f deployment-service.yml
kubectl get all
```

### 6. Install Monitoring
```bash
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts
helm repo update
kubectl create namespace monitoring
helm install prometheus prometheus-community/kube-prometheus-stack \
  --namespace monitoring \
  --set prometheus.service.type=LoadBalancer \
  --set grafana.service.type=LoadBalancer
```

## Ì≥Å Project Structure
```
Candycrush/
‚îú‚îÄ‚îÄ .github/workflows/deploy.yml     # CI/CD pipeline
‚îú‚îÄ‚îÄ Eks-terraform/                   # Terraform EKS config
‚îú‚îÄ‚îÄ monitoring/                      # Prometheus + Grafana config
‚îú‚îÄ‚îÄ deployment-service.yml           # Kubernetes manifests
‚îú‚îÄ‚îÄ Dockerfile                       # Container definition
‚îî‚îÄ‚îÄ package.json                     # Node.js dependencies
```

## Ì∑π Cleanup
```bash
helm uninstall prometheus -n monitoring
kubectl delete namespace monitoring
kubectl delete -f deployment-service.yml
cd Eks-terraform && terraform destroy --auto-approve
aws s3 rb s3://youngyz1-terraform-state --force
```

## Ì±§ Author
**Youngyz1** - [@Youngyz1](https://github.com/Youngyz1)
