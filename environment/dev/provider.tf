terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "backend-rg"
    storage_account_name = "pcslbackendforstg2025"
    container_name       = "backend-terra-container"
    key                  = ""
  }
  required_version = "1.14.2"
}

provider "azurerm" {
  features {}
  subscription_id = "e4489957-2c09-442f-936c-3a4283afbde9"
}