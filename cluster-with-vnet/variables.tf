variable "location" {
  description = "Azure region to create resources"
  default     = "East US"
}

variable "resource_prefix" {
  description = "Prefix uniquely identifies Azure resources"
  type        = string

  # validation {
  #   condition     = can(regex("^(lemon|apple|mango|banana|cherry)$", var.fruit))
  #   error_message = "Invalid fruit selected, only allowed fruits are: 'lemon', 'apple', 'mango', 'banana', 'cherry'. Default 'apple'"
  # }
}