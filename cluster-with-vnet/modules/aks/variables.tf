variable "resource_group_name" {
  description = "Name of the resource group"
}

variable "location" {
  description = "Azure region to create resources"
}

variable "aks_subnet_id" {
  description = "ID of the subnet for the AKS cluster"
}

variable "service_principal_id" {
  description = "ID of the service principal for the AKS cluster"
}

variable "service_principal_secret" {
  description = "Secret of the service principal for the AKS cluster"
  sensitive   = true
}