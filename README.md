# Restaurant Recommendation System

This project is a cloud-native application for restaurant recommendations. It includes infrastructure as code, CI/CD pipelines, and a Python-based API deployed on Azure. Below are the details of the system, its architecture, and how to deploy and use it.

---

## Architecture

- **Language**: Python (Flask + Gunicorn for WSGI)
- **Cloud Provider**: Azure
- **Infrastructure**: Managed via Terraform
- **Database**: Azure Table Storage
- **CI/CD**: GitHub Actions for Build, Test, and Deployment
- **Containerization**: Docker, with images stored on DockerHub
- **Deployment**: Azure App Service
- **Orchestration**: Optionally deployable via Helm on Kubernetes

---

## Features

1. **API Endpoints**:
    - `/insert`: Add restaurant data to Azure Table Storage.
    - `/test`: Health check endpoint.
    - `/recommend`: Fetch restaurant recommendations based on filters.

2. **CI/CD Pipelines**:
    - Application build, test, and Docker image push.
    - Terraform pipeline for infrastructure provisioning.

3. **Infrastructure**:
    - Azure Resource Group, Storage Account, and Tables for restaurants and logs.
    - Azure App Service Plan and App Service.

---

## Prerequisites

1. **Tools**:
    - Azure CLI
    - Terraform CLI
    - Docker CLI
    - kubectl (if deploying via Kubernetes)

2. **Azure Setup**:
    - Azure subscription credentials.
    - Azure Storage Account.
    - Enable the Terraform state backend using Azure Blob Storage.

---

## Deployment Steps

### 1. Clone the Repository
```bash
git clone https://github.com/edenmor/restaurant-recommender.git
cd restaurant-recommender
```

### 2. Configure Secrets
- Add these secrets in GitHub repository settings:
  - `AZURE_CLIENT_ID`
  - `AZURE_CLIENT_SECRET`
  - `AZURE_TENANT_ID`
  - `AZURE_SUBSCRIPTION_ID`
  - `DOCKERHUB_USERNAME`
  - `DOCKERHUB_TOKEN`

### 3. Terraform Infrastructure Setup

Ensure Azure credentials are configured, and initialize Terraform:

```bash
cd infra/
terraform init
terraform apply -auto-approve
```

### 4. CI/CD Pipelines

Push your code to trigger the pipelines:

- **Application Pipeline**:
  - Builds and tests the application.
  - Pushes Docker images to DockerHub.

- **Infrastructure Pipeline**:
  - Provisions Azure resources using Terraform.

### 5. Helm Deployment (Optional)

If deploying on Kubernetes:
```bash
cd helm/restaurant-app
helm install restaurant-app ./restaurant-app
```

---

## Application Usage

### Access the Application
Use the Azure App Service URL or Ingress URL (if deployed on Kubernetes):

```plaintext
https://restaurant-recommendation-app.azurewebsites.net/
```

### API Endpoints
- Insert Data:
  ```bash
  curl -X POST https://restaurant-recommendation-app.azurewebsites.net/insert -d '{"name":"Pizza Palace", "style":"Italian", "vegetarian":true}'
  ```
- Test Health:
  ```bash
  curl https://restaurant-recommendation-app.azurewebsites.net/test
  ```
- Get Recommendations:
  ```bash
  curl "https://restaurant-recommendation-app.azurewebsites.net/recommend?style=Italian&vegetarian=true"
  ```

---

## Repository Structure

```plaintext
.
├── app/                  # Python app source code
├── infra/                # Terraform scripts for infrastructure
├── helm/                 # Helm chart for Kubernetes deployment
├── .github/workflows/    # GitHub Actions pipelines
├── Dockerfile            # Dockerfile for containerization
├── requirements.txt      # Python dependencies
├── README.md             # Project documentation
```

---

## Notes

- **Logging**: API logs and requests are stored in Azure Table Storage (`requestlogs`).
- **State Management**: Terraform state is stored in Azure Blob Storage for shared access.
- **Scalability**: The system can scale by upgrading the App Service Plan or deploying on Kubernetes.

---

## Contacts

For further questions, reach out via the repository issues or contact the maintainers.
