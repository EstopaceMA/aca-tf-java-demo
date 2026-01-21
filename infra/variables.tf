variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "eastus"
}

variable "environment_name" {
  description = "The name of the environment (from azd)"
  type        = string
}

variable "principal_id" {
  description = "The principal ID of the current user or service principal"
  type        = string
  default     = ""
}

variable "tags" {
  description = "Tags to apply to all resources"
  type        = map(string)
  default     = {}
}
