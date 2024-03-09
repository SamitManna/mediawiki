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