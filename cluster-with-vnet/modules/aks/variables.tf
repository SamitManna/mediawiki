variable "aks_kubernetes_version" {
  description = "Kubernetes version"
  default = "1.28.3"
}

variable "aks_node_count" {
  description = "Node count in node pool"
  default = 2
}

variable "aks_node_vm_size" {
  description = "Node pool vm size"
  default = "Standard_D2_v2"
}

variable "aks_subnet_id" {
  description = "ID of the subnet for the AKS cluster"
}

variable "location" {
  description = "Azure region to create resources"
}

variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "resource_prefix" {
  description = "Prefix uniquely identifies Azure resources"
  type        = string
}

variable "service_principal_id" {
  description = "ID of the service principal for the AKS cluster"
}

variable "service_principal_secret" {
  description = "Secret of the service principal for the AKS cluster"
  sensitive   = true
}