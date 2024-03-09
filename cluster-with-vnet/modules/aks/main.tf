resource "azurerm_kubernetes_cluster" "aks" {
  name                = "my-aks-cluster"
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = "myakscluster"
  kubernetes_version  = "1.20.7"

  default_node_pool {
    name           = "default"
    node_count     = 2
    vm_size        = "Standard_D2_v2"
    vnet_subnet_id = var.aks_subnet_id
  }

  service_principal {
    client_id     = var.service_principal_id
    client_secret = var.service_principal_secret
  }

  network_profile {
    network_plugin = "azure"
  }
}