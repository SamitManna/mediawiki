locals {
  cluster_name = "${var.resource_prefix}-cluster"
  dns_prefix = "${var.resource_prefix}-aks-cluster-dns"
  node_pool_name = "${var.resource_prefix}"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = local.cluster_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = local.dns_prefix
  kubernetes_version  = var.aks_kubernetes_version

  default_node_pool {
    name           = local.node_pool_name
    node_count     = var.aks_node_count
    vm_size        = var.aks_node_vm_size
    vnet_subnet_id = var.aks_subnet_id
  }

  service_principal {
    client_id     = var.service_principal_id
    client_secret = var.service_principal_secret
  }

  network_profile {
    network_plugin = "azure"
    network_policy = "azure"
    service_cidr = "10.0.4.0/24"
    dns_service_ip = "10.0.4.10"
    docker_bridge_cidr = "172.17.0.1/16"
  }
}