terraform {
  backend "azurerm" {
    resource_group_name  = "tfstates"
    storage_account_name = "kstfstateaccount111111"
    container_name       = "tfstate"
    key                  = "terraform.tfstate"
  }
}  
