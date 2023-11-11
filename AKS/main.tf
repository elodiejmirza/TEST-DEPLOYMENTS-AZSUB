# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = "aks-rg"
  location = "uksouth"
}

/* # Create a subnet for the API server
resource "azurerm_subnet" "apiserver" {
  name                 = "apiserver-subnet"
  virtual_network_name = azurerm_virtual_network.aksvnet.name
  resource_group_name  = azurerm_resource_group.rg.name
  address_prefixes     = ["10.0.1.0/24"]

  # Delegate the subnet to Microsoft.ContainerService/managedClusters
  delegation {
    name = "apiserver-delegation"

    service_delegation {
      name    = "Microsoft.ContainerService/managedClusters"
      actions = ["Microsoft.Network/virtualNetworks/subnets/action"]
    }
  }
}
*/

# Create an AKS cluster with the free tier SKU
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "aks-cluster"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "aks-cluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  sku_tier = "Free" # This is the free tier SKU

  tags = {
    Environment = "Development"
    SKU = "Free"
  }
}

# Output the client certificate
/*output "client_certificate" {
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}*/

# Output the kubeconfig
output "kubeconfig" {
  value     = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}