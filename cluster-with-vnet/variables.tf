variable "location" {
  description = "Azure region to create resources"
  default     = "East US 1"
}

variable "resource_prefix" {
  description = "Prefix uniquely identifies Azure resources"
  type        = string
}