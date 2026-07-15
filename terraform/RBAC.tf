#Set your RBAC rules here

#Fetch data from App Registration for Terraform Service Principal
data "azuread_service_principal" "terraform-storage-uploader" {
  display_name = "terraform-storage-uploader"
}

#Role Assignment for Contributor for storage account
resource "azurerm_role_assignment" "contributor_storage_account" {
  scope                = azurerm_storage_account.st01-logs.id
  role_definition_name = "Contributor"
  principal_id         = data.azuread_service_principal.terraform-storage-uploader.object_id
}

