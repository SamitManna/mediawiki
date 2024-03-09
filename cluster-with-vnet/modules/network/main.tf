locals {
  vnet_name = "${var.resource_prefix}-vnet"
  subnet_name = "${var.resource_prefix}-subnet"
  azuread_app_name = "${var.resource_prefix}-ad-app"
}

resource "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  location            = var.location
  resource_group_name = var.resource_group_name
  address_space       = ["10.0.0.0/16"]
}

resource "azurerm_subnet" "aks_subnet" {
  name                 = local.subnet_name
  virtual_network_name = azurerm_virtual_network.vnet.name
  resource_group_name  = var.resource_group_name
  address_prefixes     = ["10.0.0.0/24"]
}