variable "acr_name" {
  description = "Name of the Azure Container Registry"
  type        = string
}

variable "resource_group_name" {
  description = "Resource Group in which to create the ACR"
  type        = string
}

variable "location" {
  description = "Azure location"
  type        = string
}

variable "sku" {
  description = "SKU for ACR (Basic, Standard, Premium)"
  type        = string
  default     = "Basic"
}

variable "admin_enabled" {
  description = "Enable admin access to ACR"
  type        = bool
  default     = true
}

variable "tags" {
  description = "Tags to apply to ACR"
  type        = map(string)
  default     = {}
}
