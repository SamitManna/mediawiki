output "aks_cluster_credentials" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}

output "aks_id" {
  value = azurerm_kubernetes_cluster.aks.id
  description = "The ID of the AKS cluster"
}