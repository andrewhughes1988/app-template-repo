resource "azurerm_resource_group" "app" {
  name     = "rg-app-${var.app_name}-${var.environment}"
  location = var.location
  tags     = var.tags
}

resource "azurerm_container_app" "service" {
  name                         = "ca-${var.app_name}-${var.environment}"
  container_app_environment_id = data.azurerm_container_app_environment.platform_cae.id
  resource_group_name          = azurerm_resource_group.app.name
  revision_mode                = "Single"

  template {
    container {
      name   = var.app_name
      image  = var.container_image
      cpu    = var.cpu
      memory = var.memory

      env {
        name  = "ENVIRONMENT"
        value = var.environment
      }
    }

    min_replicas = 2
    max_replicas = 10
  }

  ingress {
    external_enabled = false
    target_port      = 80
    traffic_weight {
      percentage      = 100
      latest_revision = true
    }
  }

  identity {
    type = "SystemAssigned"
  }

  tags = var.tags
}

