# try
provider "azurerm" {
  features {}
}

# Resource Group for ACR
resource "azurerm_resource_group" "default" {
  name     = "container-registry-rg"
  location = "Canada Central"

  tags = {
    environment = "Production"
  }
}

# Azure Container Registry
resource "azurerm_container_registry" "acr" {
  name                = "demotryterraformstore"
  resource_group_name = azurerm_resource_group.default.name
  location            = azurerm_resource_group.default.location
  sku                 = "Standard"
  admin_enabled       = true
}

# Resource Group for Backend Storage
resource "azurerm_resource_group" "tfstates" {
  name     = "tfstates"
  location = "Canada Central"
}

# Storage Account for Terraform State
resource "azurerm_storage_account" "tfstate" {
  name                     = "kstfstateaccount111111"
  resource_group_name      = azurerm_resource_group.tfstates.name
  location                 = azurerm_resource_group.tfstates.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

# Storage Container for Terraform State
resource "azurerm_storage_container" "tfstate" {
  name                  = "tfstate"
  storage_account_name  = azurerm_storage_account.tfstate.name
  container_access_type = "private"
}

# Outputs for ACR
output "acr_login_server" {
  value = azurerm_container_registry.acr.login_server
}

output "acr_admin_username" {
  value     = azurerm_container_registry.acr.admin_username
  sensitive = true
}

output "acr_admin_password" {
  value     = azurerm_container_registry.acr.admin_password
  sensitive = true
}
