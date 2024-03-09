output "service_principal_id" {
  value = azuread_service_principal.aks_sp.application_id
}

output "service_principal_secret" {
  value = azuread_service_principal_password.aks_sp_password.value
  sensitive = true
}