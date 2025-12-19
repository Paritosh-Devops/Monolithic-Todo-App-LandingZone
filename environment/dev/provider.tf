terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>4.0"
    }
  }
  backend "azurerm" {
    resource_group_name  = "pcsl-backend-in-rg"
    storage_account_name = "pcslstgforbkend2025"
    container_name       = "pcsl-backend-container"
    key                  = "dev.terraform.tfstate"
  }
  required_version = "1.14.3"
}

provider "azurerm" {
  features {}
  subscription_id = "e5c8e042-8d4d-4e69-8511-a29fb378ec23"
}
