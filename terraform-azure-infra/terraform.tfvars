# ============================================
# Safe Non-Sensitive Defaults
# ============================================

# Region
location            = "Central India"

# Resource Group
resource_group_name = "dev-rg"

# Networking
vnet_name      = "dev-vnet"
address_space  = ["10.0.0.0/16"]
subnet_name    = "dev-subnet"
subnet_prefix  = "10.0.1.0/24"

# Worker Node Count
worker_node_count = 1

# VM Size
vm_size        = "Standard_B2s"
admin_username = "azureuser"
