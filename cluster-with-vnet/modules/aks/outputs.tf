output "aks_cluster_credentials" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
}