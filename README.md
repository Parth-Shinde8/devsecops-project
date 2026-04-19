# 🚀 DevSecOps CI/CD Pipeline (AWS | Kubernetes | Terraform | Trivy | Checkov)

## 📌 Overview

This project implements a **production-style DevSecOps pipeline** integrating CI/CD, multi-layer security scanning, infrastructure automation, and Kubernetes deployment.

It demonstrates how modern systems ensure:

* Automated build and deployment
* Continuous security validation
* Infrastructure as Code (IaC)
* Observability and monitoring

---

## 🏗️ Architecture

```text
Developer → GitHub → GitHub Actions Pipeline
                        ↓
        ┌────────────────────────────────────┐
        │     Security & Quality Checks      │
        │  - SonarCloud (SAST)              │
        │  - Trivy (Container Scan)         │
        │  - Checkov (IaC Security)         │
        └────────────────────────────────────┘
                        ↓
                Docker Build & Push
                        ↓
              Kubernetes Deployment (EC2)
                        ↓
             Prometheus + Grafana Monitoring
```

---

## ⚙️ Tech Stack

### ☁️ Cloud & Infrastructure

* AWS (EC2, IAM, VPC, S3, DYNAMODB)
* Terraform (Infrastructure as Code)

### ⚙️ DevOps & CI/CD

* GitHub Actions
* Docker
* Kubernetes

### 🔐 DevSecOps (Security)

* SonarCloud → Static Code Analysis (SAST)
* Trivy → Container Vulnerability Scanning
* Checkov → Terraform Security Scanning

### 📊 Monitoring

* Prometheus
* Grafana

---

## 🔄 CI/CD Pipeline Workflow

1. Code pushed to GitHub (main branch)
2. GitHub Actions pipeline is triggered
3. Security & quality checks executed:

   * SonarCloud scans codebase
   * Trivy scans Docker images
   * Checkov scans Terraform configurations
4. Docker images are built and tagged
5. Images pushed to Docker Hub
6. Application deployed to Kubernetes (EC2)
7. Rolling restart ensures updated deployment

---

## 🔐 Security Scanning Strategy

### 🔎 SonarCloud (SAST)

```yaml
continue-on-error: true
```

* Pipeline continues even if Quality Gate fails
* Ensures visibility without blocking deployment

**Production Note:**
In real environments, Quality Gates should block deployment on failure.

---

### 🐳 Trivy (Container Security)

```bash
trivy image --severity HIGH,CRITICAL <image-name>
```

* Scans Docker images for:

  * OS vulnerabilities
  * Dependency vulnerabilities
* Reports HIGH & CRITICAL issues directly in pipeline logs

**Important Design Choice:**

* No forced exit override (`--exit-code 0`) is used
* Pipeline behavior reflects actual scan results
* Maintains transparency of security findings

---

### 🔐 Checkov (IaC Security)

```yaml
soft_fail: true
```

* Scans Terraform code for:

  * Misconfigurations
  * Security risks
* Runs in non-blocking mode for demonstration

**Production Note:**
Should be enforced strictly to prevent insecure infrastructure deployment.

---

## 📸 Pipeline Results

* ✅ CI/CD pipeline executes successfully
* ⚠️ Security vulnerabilities (if any) are reported but not blocked


---


## 🚀 Deployment Strategy

* Multi-service Docker build (microservices architecture)
* Images pushed to Docker Hub
* Kubernetes deployment via `kubectl apply`
* Rolling restart ensures zero downtime updates

---

## 🎯 Key Highlights

* End-to-end DevSecOps pipeline
* Multi-layer security scanning (SAST + Container + IaC)
* Real-world CI/CD workflow using GitHub Actions
* Microservices-based architecture
* Kubernetes deployment with automated rollout
* Security-first design with visible scan outputs

---

## 📈 Future Improvements

* Enforce blocking security gates (production mode)
* Add Slack/Email alerting for pipeline failures
* Implement GitOps using ArgoCD
* Add automated rollback strategy
* Store scan reports as artifacts

---

## 👨‍💻 Author

**Parth Shinde**

---

## ⭐ Final Note

This project reflects **real-world DevSecOps practices**, balancing:

* ✔ Continuous deployment
* ✔ Continuous security monitoring
* ✔ Practical non-blocking pipelines for development

It demonstrates how security is integrated into every stage of the CI/CD lifecycle.

---
