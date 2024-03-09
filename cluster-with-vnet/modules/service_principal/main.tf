resource "azuread_application" "aks_app" {
  name = "my-aks-app"
}

resource "azuread_service_principal" "aks_sp" {
  application_id = azuread_application.aks_app.application_id
}

resource "azuread_service_principal_password" "aks_sp_password" {
  service_principal_id = azuread_service_principal.aks_sp.id
  end_date_relative    = "8760h" # 1 year validity
}