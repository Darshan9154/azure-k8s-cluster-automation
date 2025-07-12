# ==============================================
# Master Node Outputs
# ==============================================

# 🔍 Output the Master Node Public IP
output "master_public_ip" {
  description = "The Public IP address of the Kubernetes master node"
  value       = azurerm_public_ip.master.ip_address
}

# (Optional) Output the Master Node Private IP (useful for debugging)
output "master_private_ip" {
  description = "The Private IP address of the Kubernetes master node"
  value       = azurerm_network_interface.master.private_ip_address
}

# (Optional) Output the Master Node VM ID (for advanced automation)
output "master_vm_id" {
  description = "The Azure VM resource ID for the Kubernetes master node"
  value       = azurerm_linux_virtual_machine.master.id
}
