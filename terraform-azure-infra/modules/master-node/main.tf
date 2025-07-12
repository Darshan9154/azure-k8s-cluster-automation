# ==============================================
# Master Node VM Module
# ==============================================

resource "azurerm_public_ip" "master" {
  name                = "master-public-ip"
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"   # ✅ Must be static
  sku                 = "Standard" # ✅ Make SKU explicit if needed
}


# 🔍 Create Network Interface (NIC)
resource "azurerm_network_interface" "master" {
  name                = "master-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.master.id
  }
}

# 🔍 Create Ubuntu Virtual Machine
resource "azurerm_linux_virtual_machine" "master" {
  name                = "k8s-master-vm"
  resource_group_name = var.resource_group_name
  location            = var.location
  size                = var.vm_size
  admin_username      = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.master.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}
