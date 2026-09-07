# Discover the Platform-managed Container App Environment via Azure ARM (Zero state reading)
data "azurerm_container_app_environment" "platform_cae" {
  name                = var.container_app_environment_name
  resource_group_name = var.platform_hosting_resource_group
}

