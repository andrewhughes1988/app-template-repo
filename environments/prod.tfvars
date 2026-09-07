environment = "prod"
location    = "eastus"
app_name    = "order-service"

# Platform CAE Discovery Contract
platform_hosting_resource_group = "rg-hosting-cae-prod"
container_app_environment_name  = "cae-shared-prod-eastus"

container_image = "mcr.microsoft.com/k8se/quickstart:latest"
cpu             = 1.0
memory          = "2Gi"

tags = {
  Environment = "prod"
  Application = "OrderService"
  Team        = "AppTeam-001"
  ManagedBy   = "Terraform"
}
