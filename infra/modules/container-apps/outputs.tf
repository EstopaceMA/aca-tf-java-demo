output "environment_id" {
  description = "The ID of the container app environment"
  value       = azurerm_container_app_environment.this.id
}

output "environment_name" {
  description = "The name of the container app environment"
  value       = azurerm_container_app_environment.this.name
}

output "app_id" {
  description = "The ID of the container app"
  value       = azurerm_container_app.this.id
}

output "app_name" {
  description = "The name of the container app"
  value       = azurerm_container_app.this.name
}

output "app_fqdn" {
  description = "The FQDN of the container app"
  value       = azurerm_container_app.this.ingress[0].fqdn
}

output "app_url" {
  description = "The URL of the container app"
  value       = "https://${azurerm_container_app.this.ingress[0].fqdn}"
}

output "log_analytics_workspace_id" {
  description = "The ID of the log analytics workspace"
  value       = azurerm_log_analytics_workspace.this.id
}
