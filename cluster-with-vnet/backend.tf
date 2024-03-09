terraform {
  backend "azurerm" {
    resource_group_name  = "terraform-backend-rg"
    storage_account_name = "tfstatesamitmanna"
    container_name       = "terraform-state"
    # key                  = "environments/production/terraform.tfstate" passed from actions
  }
}