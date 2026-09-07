variable "environment" {
  description = "Target deployment environment (dev, prod)."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "app_name" {
  description = "Name of the application microservice."
  type        = string
  default     = "order-service"
}

variable "platform_hosting_resource_group" {
  description = "Resource Group where Platform Ops deployed the Container App Environment."
  type        = string
}

variable "container_app_environment_name" {
  description = "Name of the Platform Container App Environment."
  type        = string
}

variable "container_image" {
  description = "Container image to run."
  type        = string
  default     = "mcr.microsoft.com/k8se/quickstart:latest"
}

variable "cpu" {
  description = "CPU allocation."
  type        = number
  default     = 0.5
}

variable "memory" {
  description = "Memory allocation."
  type        = string
  default     = "1Gi"
}

variable "tags" {
  description = "Application tags."
  type        = map(string)
  default     = {}
}

