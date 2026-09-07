environment = "dev"
location    = "eastus"
app_name    = "order-service"

# Platform CAE Discovery Contract
platform_hosting_resource_group = "rg-hosting-cae-dev"
container_app_environment_name  = "cae-shared-dev-eastus"

container_image = "mcr.microsoft.com/k8se/quickstart:latest"
cpu             = 0.5
memory          = "1Gi"

tags = {
  Environment = "dev"
  Application = "OrderService"
  Team        = "AppTeam-001"
  ManagedBy   = "Terraform"
}

