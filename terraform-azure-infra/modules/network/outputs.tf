# ==============================================
# Network Module Outputs
# ==============================================

# 🔍 Output the Virtual Network ID
output "vnet_id" {
  description = "The ID of the created Virtual Network"
  value       = azurerm_virtual_network.main.id
}

# 🔍 Output the Subnet ID
output "subnet_id" {
  description = "The ID of the created Subnet"
  value       = azurerm_subnet.main.id
}

# 🔍 Output the NSG ID (optional, for debugging or future use)
output "nsg_id" {
  description = "The ID of the created Network Security Group"
  value       = azurerm_network_security_group.main.id
}
