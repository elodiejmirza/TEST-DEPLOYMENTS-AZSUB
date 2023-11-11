
resource "azurerm_virtual_network" "vnet-lnxvm-uksouth-001" {
  name                = "vnet-lnxvm-uksouth-001"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-lnxvm-uksouth-001.location
  resource_group_name = azurerm_resource_group.rg-lnxvm-uksouth-001.name
}

resource "azurerm_subnet" "snet-lnxvm-uksouth-001" {
  name                 = "snet-lnxvm-uksouth-001"
  resource_group_name  = azurerm_resource_group.rg-lnxvm-uksouth-001.name
  virtual_network_name = azurerm_virtual_network.vnet-lnxvm-uksouth-001.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "pip-lnxvm-uksouth-001" {
  name                = "pip-lnxvm-uksouth-001"
  resource_group_name = azurerm_resource_group.rg-lnxvm-uksouth-001.name
  location            = azurerm_resource_group.rg-lnxvm-uksouth-001.location
  allocation_method   = "Dynamic"
}

resource "azurerm_network_interface" "nic-lnxvm-uksouth-001" {
  name                = "nic-lnxvm-uksouth-001"
  location            = azurerm_resource_group.rg-lnxvm-uksouth-001.location
  resource_group_name = azurerm_resource_group.rg-lnxvm-uksouth-001.name

  ip_configuration {
    name                          = "internal-lnxvm-uksouth-001"
    subnet_id                     = azurerm_subnet.snet-lnxvm-uksouth-001.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.pip-lnxvm-uksouth-001.id
    }
}

resource "azurerm_network_security_group" "nsg-lnxvm-uksouth-001" {
  name                = "nsg-lnxvm-uksouth-001"
  location            = azurerm_resource_group.rg-lnxvm-uksouth-001.location
  resource_group_name = azurerm_resource_group.rg-lnxvm-uksouth-001.name

  security_rule {
    name                       = "SSH"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "217.155.12.72/32"
    destination_address_prefix = "*"
  }

  security_rule {
    name                       = "RDP"
    priority                   = 101
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "3389"
    source_address_prefix      = "217.155.12.72/32"
    destination_address_prefix = "*"
  }
  
  security_rule {
    name                       = "DenyAllInbound"
    priority                   = 300
    direction                  = "Inbound"
    access                     = "Deny"
    protocol                   = "*"
    source_port_range          = "*"
    destination_port_range     = "*"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_subnet_network_security_group_association" "nsg-ass-net-lnxvm-uksouth-001" {
  subnet_id                 = azurerm_subnet.snet-lnxvm-uksouth-001.id
  network_security_group_id = azurerm_network_security_group.nsg-lnxvm-uksouth-001.id
}

output "public_ip_address" {
  value = azurerm_public_ip.pip-lnxvm-uksouth-001.ip_address
}