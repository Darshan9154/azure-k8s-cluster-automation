# ============================================
# Safe Non-Sensitive Defaults
# ============================================

# Azure Region
location = "Central India"

# Resource Group
resource_group_name = "dev-rg"

# Networking
vnet_name     = "dev-vnet"
address_space = ["10.0.0.0/16"]
subnet_name   = "dev-subnet"
subnet_prefix = "10.0.1.0/24"

# Worker Node Configuration
worker_node_count = 1

# VM Configuration
vm_size        = "Standard_B2s"
admin_username = "azureuser"

# Azure Container Registry (ACR)
acr_name = "darshanacr98765"

# Azure Key Vault
key_vault_name  = "darshan-kv-x9a7f3b2"
tenant_id      = "9f838c07-4a4e-4b6c-835c-554fa9617715"
object_id      = "cd90105b-437a-4a5b-8edc-3abf78c03e5e"  # ✅ Replace if needed
