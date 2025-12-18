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
  subscription_id = "e4489957-2c09-442f-936c-3a4283afbde9"
}