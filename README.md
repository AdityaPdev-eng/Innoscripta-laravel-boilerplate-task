# Laravel 10 DevOps Assessment

**Name:** Tushar
**Email:** [your-email@example.com](mailto:your-email@example.com)

---

## 📌 Overview

This repository demonstrates a **production‑ready DevOps setup** for a Laravel 10 application.
The focus of this assessment is **infrastructure design, containerization, Helm‑based Kubernetes deployment, and CI/CD**, not application feature development.

The solution includes:

* Modular **Terraform** for AWS VPC, EKS, and IAM
* **Docker** image for Laravel application
* **Helm chart** with separate PHP‑FPM and Worker deployments
* **GitHub Actions CI/CD** with multiple environments
* Best‑practice configuration using ConfigMaps and Secrets

---

## 🏗️ Architecture Summary

```
VPC (Terraform Module)
 └── EKS Cluster (Terraform Module)
      ├── PHP‑FPM Deployment (Helm)
      ├── Queue Worker Deployment (Helm)
      ├── Service
      ├── Ingress
      ├── ConfigMap
      └── Secret
```

---

## 🌐 Terraform Structure & Modules

Terraform is organized using reusable modules to maintain clear separation of concerns.

```
terraform/
├── modules/
│   ├── vpc/      # Networking (VPC, subnets, NAT)
│   ├── eks/      # Kubernetes cluster
│   └── iam/      # Restricted IAM user
├── main.tf
├── variables.tf
├── outputs.tf
└── versions.tf
```

### Modules Description

* **VPC module**
  Creates public and private subnets, NAT Gateway, and networking resources.

* **EKS module**
  Provisions an Amazon EKS cluster using private subnets from the VPC module.

* **IAM module**
  Creates an IAM user with access limited to **EKS and ECR only** (used for evaluation).

> ⚠️ Note: Terraform code is written to be executable, but actual AWS resources are not required to be created for this assessment.

### Terraform Commands

```bash
cd terraform
terraform init
terraform validate
terraform plan
```

---

## 🐳 Docker Setup

A single Docker image is used for both:

* PHP‑FPM application
* Laravel queue workers

The container runs as a **non‑root user**, following security best practices.

### Local Development

```bash
docker-compose up --build
```

---

## ⎈ Helm Chart Structure

The application is deployed using a Helm chart.

```
helm/laravel-app/
├── Chart.yaml
├── values.yaml            # Default values
├── values-dev.yaml        # Development environment
├── values-staging.yaml    # Staging environment
├── values-prod.yaml       # Production environment
└── templates/
    ├── deployment-php.yaml
    ├── deployment-worker.yaml
    ├── service.yaml
    ├── ingress.yaml
    ├── configmap.yaml
    └── secret.yaml
```

### Key Helm Design Decisions

* **Two Deployments**

  * PHP‑FPM deployment for handling requests
  * Worker deployment running `php artisan queue:work`

* **Single reusable Helm chart**

  * Environment‑specific configuration handled via values files

* **Dynamic Docker image configuration**

  * Image repository and tag are injected at deploy time via CI/CD

### Helm Commands

```bash
helm lint helm/laravel-app
helm template laravel helm/laravel-app -f helm/laravel-app/values-dev.yaml
helm upgrade --install laravel helm/laravel-app --dry-run
```

---

## 🚀 CI/CD with GitHub Actions

The CI/CD pipeline is implemented using **GitHub Actions** and follows a branch‑based environment strategy.

### Branch → Environment Mapping

| Git Branch  | Environment |
| ----------- | ----------- |
| development | Development |
| staging     | Staging     |
| main        | Production  |

### Pipeline Stages

1. **Test**

   * Triggered when a Pull Request is opened against `main`
   * If tests fail, merge is blocked

2. **Build**

   * Docker image is built and pushed to DockerHub
   * Image tag is based on Git commit SHA

3. **Deploy**

   * Helm deploy is executed using environment‑specific values
   * Image tag and repository are injected dynamically
   * Deployment is run using `--dry-run` for safety

### Required GitHub Secrets

* `DOCKERHUB_USERNAME`
* `DOCKERHUB_TOKEN`

---

## 🗄️ Database Handling

A real database setup is **intentionally excluded** from this assessment.

* Laravel requires database configuration at runtime
* Placeholder values are provided via ConfigMap and Secret
* The Helm chart is **database‑agnostic** and can easily integrate with RDS or any managed database in a real environment

---

## 🔐 Security Considerations (Optional)

* Non‑root Docker container
* Secrets managed via Kubernetes Secret
* IAM user restricted to minimum required permissions
* Image tags are immutable (commit‑based)

---

## 📈 Possible Improvements

* Add Trivy image scanning in CI/CD
* Enable Helm release versioning
* Add manual approval for production deployments
* Integrate real database (RDS) via Terraform

---

## ✅ Conclusion

This project demonstrates a clean, modular, and scalable DevOps setup aligned with real‑world best practices.
The same Helm chart and CI/CD pipeline can be reused across multiple environments with minimal changes.

---

**Thank you for reviewing this assessment.**
