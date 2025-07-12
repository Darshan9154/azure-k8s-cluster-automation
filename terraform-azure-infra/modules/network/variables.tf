# ==============================================
# Network Module Variables
# ==============================================

# 🔍 Azure Location (Region)
variable "location" {
  description = "Azure region where the resources will be created"
  type        = string
}

# 🔍 Azure Resource Group Name
variable "resource_group_name" {
  description = "Name of the resource group where resources will be created"
  type        = string
}

# 🔍 Virtual Network Name
variable "vnet_name" {
  description = "Name of the Virtual Network"
  type        = string
}

# 🔍 Virtual Network Address Space
variable "address_space" {
  description = "CIDR block for the Virtual Network"
  type        = list(string)
}

# 🔍 Subnet Name
variable "subnet_name" {
  description = "Name of the subnet inside the Virtual Network"
  type        = string
}

# 🔍 Subnet Prefix
variable "subnet_prefix" {
  description = "CIDR block for the subnet"
  type        = string
}
