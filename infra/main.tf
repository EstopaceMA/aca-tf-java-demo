terraform {
  required_version = ">= 1.0"

  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.100"
    }
    azurecaf = {
      source  = "aztfmod/azurecaf"
      version = "~> 1.2"
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.6"
    }
  }
}

provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

# Random suffix for unique resource names
resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

# Azure CAF naming
resource "azurecaf_name" "resource_group" {
  name          = var.environment_name
  resource_type = "azurerm_resource_group"
  random_length = 0
  clean_input   = true
}

resource "azurecaf_name" "container_registry" {
  name          = var.environment_name
  resource_type = "azurerm_container_registry"
  random_length = 0
  clean_input   = true
}

resource "azurecaf_name" "container_app_environment" {
  name          = var.environment_name
  resource_type = "azurerm_container_app_environment"
  random_length = 0
  clean_input   = true
}

resource "azurecaf_name" "log_analytics" {
  name          = var.environment_name
  resource_type = "azurerm_log_analytics_workspace"
  random_length = 0
  clean_input   = true
}

resource "azurecaf_name" "postgresql" {
  name          = var.environment_name
  resource_type = "azurerm_postgresql_flexible_server"
  random_length = 0
  clean_input   = true
}

# Resource Group
module "resource_group" {
  source = "./modules/resource-group"

  name     = azurecaf_name.resource_group.result
  location = var.location
  tags     = var.tags
}

# Container Registry
module "container_registry" {
  source = "./modules/container-registry"

  name                = "${replace(azurecaf_name.container_registry.result, "-", "")}${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  sku                 = "Basic"
  admin_enabled       = true
  tags                = var.tags
}

# PostgreSQL
module "postgresql" {
  source = "./modules/postgresql"

  name                = "${azurecaf_name.postgresql.result}-${random_string.suffix.result}"
  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  database_name       = "todo"
  tags                = var.tags
}

# Container Apps
module "container_apps" {
  source = "./modules/container-apps"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location
  environment_name    = azurecaf_name.container_app_environment.result
  log_analytics_name  = azurecaf_name.log_analytics.result
  app_name            = "backend"
  container_image     = "${module.container_registry.login_server}/backend:latest"
  registry_server     = module.container_registry.login_server
  registry_username   = module.container_registry.admin_username
  registry_password   = module.container_registry.admin_password
  db_password         = module.postgresql.administrator_password
  tags                = var.tags

  environment_variables = [
    {
      name  = "QUARKUS_DATASOURCE_JDBC_URL"
      value = module.postgresql.connection_string
    },
    {
      name  = "QUARKUS_DATASOURCE_USERNAME"
      value = module.postgresql.administrator_login
    },
    {
      name        = "QUARKUS_DATASOURCE_PASSWORD"
      secret_name = "db-password"
    },
    {
      name  = "QUARKUS_HIBERNATE_ORM_DATABASE_GENERATION"
      value = "update"
    }
  ]
}
