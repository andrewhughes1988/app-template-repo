output "app_id" {
  description = "Resource ID of the Container App."
  value       = azurerm_container_app.service.id
}

output "app_name" {
  description = "Name of the Container App."
  value       = azurerm_container_app.service.name
}

output "fqdn" {
  description = "Internal FQDN of the Container App."
  value       = azurerm_container_app.service.latest_revision_fqdn
}

