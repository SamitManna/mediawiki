variable "resource_prefix" {
  description = "Prefix uniquely identifies Azure resources"
  type        = string
}

variable "service_principal_password_validity" {
  description = "Service Principal Password Validity"
  default     = "8760h" #1year
}