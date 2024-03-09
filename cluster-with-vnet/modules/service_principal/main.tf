locals {
  azuread_app_name = "${var.resource_prefix}-ad-app"
}

resource "azuread_application" "aks_app" {
  name = local.azuread_app_name
}

resource "azuread_service_principal" "aks_sp" {
  application_id = azuread_application.aks_app.application_id
}

resource "random_string" "password" {
  length  = 32
  special = true
}

resource "azuread_service_principal_password" "aks_sp_password" {
  service_principal_id = azuread_service_principal.aks_sp.object_id
  end_date_relative    = var.service_principal_password_validity
  value                = random_string.password.result
}