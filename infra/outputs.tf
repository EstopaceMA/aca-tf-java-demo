output "AZURE_RESOURCE_GROUP" {
  description = "The name of the resource group"
  value       = module.resource_group.name
}

output "AZURE_CONTAINER_REGISTRY_NAME" {
  description = "The name of the container registry"
  value       = module.container_registry.name
}

output "AZURE_CONTAINER_REGISTRY_ENDPOINT" {
  description = "The login server of the container registry"
  value       = module.container_registry.login_server
}

output "AZURE_CONTAINER_ENVIRONMENT_NAME" {
  description = "The name of the container app environment"
  value       = module.container_apps.environment_name
}

output "BACKEND_URI" {
  description = "The URL of the backend container app"
  value       = module.container_apps.app_url
}

output "POSTGRESQL_FQDN" {
  description = "The FQDN of the PostgreSQL server"
  value       = module.postgresql.fqdn
  sensitive   = true
}

output "POSTGRESQL_DATABASE_NAME" {
  description = "The name of the PostgreSQL database"
  value       = module.postgresql.database_name
}
