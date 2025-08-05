# ==============================================
# Minimal Main File to Test Azure Container Registry and Key Vault
# ==============================================


# 🔹 Create Resource Group (used by ACR and Key Vault)
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# 🔹 ACR Module
module "acr" {
  source              = "./modules/acr"
  acr_name            = var.acr_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  sku                 = "Basic"
  admin_enabled       = true
  tags = {
    environment = "test"
    owner       = "acr-test"
  }
}

# 🔹 Key Vault Module
module "key_vault" {
  source              = "./modules/key_vault"
  key_vault_name      = var.key_vault_name
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  tenant_id           = var.tenant_id
  object_id           = var.object_id
  tags = {
    environment = "dev"
    owner       = "terraform"
  }
}
