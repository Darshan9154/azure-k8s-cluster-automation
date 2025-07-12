# ==============================================
# VMSS Workers Module Variables
# ==============================================

# 🔍 Azure Region
variable "location" {
  description = "Azure region where the worker nodes will be created"
  type        = string
}

# 🔍 Resource Group Name
variable "resource_group_name" {
  description = "The Azure Resource Group for the VMSS"
  type        = string
}

# 🔍 Subnet ID where the VMSS will be deployed
variable "subnet_id" {
  description = "The subnet ID where the worker nodes will be created"
  type        = string
}

# 🔍 Admin Username for SSH login
variable "admin_username" {
  description = "Admin username for the worker nodes"
  type        = string
}

# 🔍 SSH Public Key for authentication
variable "ssh_public_key" {
  description = "The SSH public key for accessing worker nodes"
  type        = string
}

# 🔍 Azure VM Size
variable "vm_size" {
  description = "Azure VM size to use for worker nodes (e.g., Standard_B2ms)"
  type        = string
}

# 🔍 Number of worker instances to create
variable "instance_count" {
  description = "Number of worker nodes to create in the VM Scale Set"
  type        = number
  default     = 2
}
variable "vmss_name" {
  description = "Name of the VM Scale Set"
  type        = string
}
