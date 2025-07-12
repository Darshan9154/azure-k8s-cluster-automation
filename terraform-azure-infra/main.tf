# ==============================================
# Root Main File - Orchestrates All Modules
# ==============================================

# ----------------------------------------------
# 🔹 Create Azure Resource Group
# ----------------------------------------------
resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

# ----------------------------------------------
# 🔹 Call Network Module
# - Creates VNet, Subnet, NSG
# ----------------------------------------------
module "network" {
  source              = "./modules/network"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  subnet_name         = var.subnet_name
  subnet_prefix       = var.subnet_prefix
}

# ----------------------------------------------
# 🔹 Call Master Node Module
# - Creates a single Ubuntu VM for Kubernetes Master
# ----------------------------------------------
module "master-node" {
  source              = "./modules/master-node"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  vm_size             = var.vm_size
}

# ----------------------------------------------
# 🔹 Call Worker Node VMSS Module
# - Creates a VM Scale Set for Kubernetes Worker Nodes
# ----------------------------------------------
module "vmss-workers" {
  source              = "./modules/vmss-workers"
  location            = var.location
  resource_group_name = azurerm_resource_group.main.name
  subnet_id           = module.network.subnet_id
  admin_username      = var.admin_username
  ssh_public_key      = var.ssh_public_key
  vm_size             = var.vm_size
  instance_count      = var.worker_node_count
  vmss_name           = "k8s-worker-vmss"
}

