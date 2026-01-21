variable "name" {
  description = "The name of the PostgreSQL server"
  type        = string
}

variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "postgresql_version" {
  description = "The version of PostgreSQL"
  type        = string
  default     = "16"
}

variable "administrator_login" {
  description = "The administrator login"
  type        = string
  default     = "psqladmin"
}

variable "storage_mb" {
  description = "The storage size in MB"
  type        = number
  default     = 32768
}

variable "sku_name" {
  description = "The SKU name"
  type        = string
  default     = "B_Standard_B1ms"
}

variable "backup_retention_days" {
  description = "Backup retention days"
  type        = number
  default     = 7
}

variable "geo_redundant_backup_enabled" {
  description = "Enable geo-redundant backup"
  type        = bool
  default     = false
}

variable "public_network_access_enabled" {
  description = "Enable public network access"
  type        = bool
  default     = true
}

variable "database_name" {
  description = "The name of the database"
  type        = string
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
