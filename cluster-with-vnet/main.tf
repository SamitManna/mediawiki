# Create a resource group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}

module "network" {
  source              = "./modules/network"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
}

module "service_principal" {
  source = "./modules/service_principal"
}

module "aks" {
  source                 = "./modules/aks"
  resource_group_name    = azurerm_resource_group.rg.name
  location               = azurerm_resource_group.rg.location
  aks_subnet_id          = module.network.aks_subnet_id
  service_principal_id   = module.service_principal.service_principal_id
  service_principal_secret = module.service_principal.service_principal_secret
}