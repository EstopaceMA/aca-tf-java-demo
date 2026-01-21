variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
}

variable "location" {
  description = "The Azure region"
  type        = string
}

variable "environment_name" {
  description = "The name of the container app environment"
  type        = string
}

variable "log_analytics_name" {
  description = "The name of the log analytics workspace"
  type        = string
}

variable "app_name" {
  description = "The name of the container app"
  type        = string
}

variable "container_image" {
  description = "The container image (ignored - uses placeholder for initial deploy)"
  type        = string
  default     = ""
}

variable "target_port" {
  description = "The target port"
  type        = number
  default     = 8080
}

variable "cpu" {
  description = "CPU allocation"
  type        = number
  default     = 0.5
}

variable "memory" {
  description = "Memory allocation"
  type        = string
  default     = "1Gi"
}

variable "min_replicas" {
  description = "Minimum replicas"
  type        = number
  default     = 0
}

variable "max_replicas" {
  description = "Maximum replicas"
  type        = number
  default     = 3
}

variable "registry_server" {
  description = "The container registry server"
  type        = string
}

variable "registry_username" {
  description = "The container registry username"
  type        = string
}

variable "registry_password" {
  description = "The container registry password"
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "The database password"
  type        = string
  sensitive   = true
}

variable "environment_variables" {
  description = "Environment variables for the container"
  type = list(object({
    name        = string
    value       = optional(string)
    secret_name = optional(string)
  }))
  default = []
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}
