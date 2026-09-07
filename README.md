# Application Example Repository (`app-example-001`)

This repository serves as a **Golden Template and Reference Implementation** for application engineering teams deploying cloud-native microservices into enterprise Azure Landing Zones.

---

## Architectural Role: Payload vs. Platform

In this architecture, application teams own the **Application Payload**, while Platform Ops owns the **Hosting Infrastructure**:

```
+-------------------------------------------------------------+
| PLATFORM OPS (azure-platform-core)                          |
|  - Provisions: CAE "cae-shared-dev" in Spoke VNet           |
|  - State: compute/cae/dev.tfstate                           |
+------------------------------+------------------------------+
                               | Discovered via Azure ARM API
                               v
+-------------------------------------------------------------+
| APP TEAM (app-example-001)                                  |
|  - Deploys: Container App "ca-order-service-dev"            |
|  - Owns: Replicas, scaling rules, container images, ingress |
|  - State: app-example-001/dev.tfstate                       |
+-------------------------------------------------------------+
```

### Key Benefits:
1. **Zero State Collisions**: This repo maintains its own isolated `.tfstate` blob. The app team can deploy 50 times a day without locking platform state or other application states.
2. **Contract-Driven Binding**: The app binds to the platform's Container App Environment using **Azure ARM Native Data Sources (`data "azurerm_container_app_environment"`)**. No platform state files are read.
3. **Inherited Enterprise Security**: CI/CD runs using the standardized pipeline in [`platform-deployment-cicd`](../platform-deployment-cicd) with cryptographic Azure OIDC claim verification.

---

## Repository Structure

```
app-example-001/
├── .github/
│   ├── workflows/deploy.yml     # 15-line caller stub pointing to central CI/CD
│   └── CODEOWNERS               # Locks .github/ to Platform Admins
├── backend.tf                   # Parameter-less azurerm backend
├── versions.tf                  # Provider constraints
├── data.tf                      # Discovers platform-managed CAE
├── main.tf                      # Provisions azurerm_container_app
├── variables.tf
├── outputs.tf
├── backend/
│   └── dev.backend.tfvars       # Independent state: app-example-001/dev.tfstate
└── environments/
    └── dev.tfvars               # Application-level runtime variables
```

---

## How-To: Local Execution

### Step 1: Initialize Backend
```bash
terraform init -backend-config=backend/dev.backend.tfvars
```

### Step 2: Generate Plan
```bash
terraform plan -var-file=environments/dev.tfvars -out=tfplan
```

### Step 3: Apply Changes
```bash
terraform apply tfplan
```

---

## CI/CD Deployment Workflow

Every Pull Request automatically triggers the reusable workflow in `platform-deployment-cicd`:
- Runs `terraform fmt`, `tflint`, and `trivy`.
- Authenticates to Azure via OIDC (strictly validated by Azure using the `job_workflow_ref` claim).
- Generates a speculative execution plan and posts it as a PR comment.
- Merging to `main` executes `terraform apply` with environment approvals.

