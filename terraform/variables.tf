#AD Tenant ID
variable "tenant_id" {
  description = "The Azure AD tenant ID"
  type        = string
  default     = "<YOUR_TENANT_ID>"
}


#Resource Group Details
variable "resource_group_name" {
  description = "The name of the resource group"
  type        = string
  default     = "rg-infra-02-vm"
}
variable "resource_group_location" {
  description = "The location of the resource group"
  type        = string
  default     = "East US"
}


#Storage Account Details
variable "storage_account_name" {
  description = "The name of the storage account"
  type        = string
  default     = "st01logs"
}
