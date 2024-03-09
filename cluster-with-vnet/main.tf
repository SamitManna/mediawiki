locals {
  resource_group_name = "${var.resource_prefix}-rg"
  cluster_name        = "${var.resource_prefix}-cluster"
}

resource "azurerm_resource_group" "rg" {
  name     = local.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  resource_prefix     = var.resource_prefix
}

module "service_principal" {
  source          = "./modules/service_principal"
  resource_prefix = var.resource_prefix
}

module "aks" {
  source                   = "./modules/aks"
  aks_subnet_id            = module.network.aks_subnet_id
  location                 = azurerm_resource_group.rg.location
  resource_group_name      = azurerm_resource_group.rg.name
  resource_prefix          = var.resource_prefix
  service_principal_id     = module.service_principal.service_principal_id
  service_principal_secret = module.service_principal.service_principal_secret
}