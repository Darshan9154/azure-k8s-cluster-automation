# ============================================
# Root Variables
# ============================================

variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "Central India"
}

variable "resource_group_name" {
  description = "Name of the Azure Resource Group"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

variable "address_space" {
  description = "Address space for the VNet"
  type        = list(string)
}

variable "subnet_name" {
  description = "Name of the Subnet"
  type        = string
}

variable "subnet_prefix" {
  description = "CIDR prefix for the Subnet"
  type        = string
}

variable "admin_username" {
  description = "Admin username for the VMs"
  type        = string
}

variable "ssh_public_key" {
  description = "SSH Public Key for authentication"
  type        = string
}

variable "vm_size" {
  description = "VM size for the master and worker nodes"
  type        = string
  default     = "Standard_B2s"
}

variable "worker_node_count" {
  description = "Number of VMSS worker node instances"
  type        = number
  default     = 1
}

# --------------------------------------------
# 🔹 Azure Container Registry (ACR)
# --------------------------------------------

variable "acr_name" {
  type        = string
  description = "Globally unique name for ACR"
}
variable "key_vault_name" {
  description = "Name of the Key Vault"
  type        = string
}

variable "tenant_id" {
  description = "Tenant ID (from your .env)"
  type        = string
}

variable "object_id" {
  description = "Object ID of your service principal or user"
  type        = string
}

