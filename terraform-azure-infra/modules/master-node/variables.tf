# ==============================================
# Master Node Variables
# ==============================================

# 🔍 Azure Region
variable "location" {
  description = "Azure region where the VM will be created"
  type        = string
}

# 🔍 Resource Group Name
variable "resource_group_name" {
  description = "The resource group in which to create the VM"
  type        = string
}

# 🔍 Subnet ID where the master node VM will reside
variable "subnet_id" {
  description = "The subnet ID for the network interface of the master VM"
  type        = string
}

# 🔍 Admin Username for SSH login
variable "admin_username" {
  description = "The admin username for the VM"
  type        = string
}

# 🔍 SSH Public Key for the admin user
variable "ssh_public_key" {
  description = "The SSH public key for secure login to the VM"
  type        = string
}

# 🔍 Azure VM Size
variable "vm_size" {
  description = "The Azure VM size to deploy (e.g., Standard_B2ms)"
  type        = string
}
