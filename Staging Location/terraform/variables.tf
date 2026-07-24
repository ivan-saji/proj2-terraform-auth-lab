#AD Tenant ID
variable "tenant_id" {
  description = "The Azure AD tenant ID"
  type        = string
  default     = "8316e695-7e94-4716-92c4-836cee1dc7ce"
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

variable "sp_client_id" {
  type      = string
  sensitive = true
}

variable "sp_client_secret" {
  type      = string
  sensitive = true
}

variable "sp_tenant_id" {
  type = string
}