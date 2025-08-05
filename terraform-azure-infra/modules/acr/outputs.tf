output "acr_login_server" {
  description = "Login server URL for the ACR"
  value       = azurerm_container_registry.this.login_server
}

output "acr_name" {
  value = azurerm_container_registry.this.name
}
