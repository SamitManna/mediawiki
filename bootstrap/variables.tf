variable "location" {
  description = "Azure region to create resources"
  default     = "East US"
}

variable "resource_group_name" {
  description = "Name of the resource group"
  default     = "terraform-backend-rg"
}