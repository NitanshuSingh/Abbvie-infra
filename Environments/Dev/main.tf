terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "4.34.0"
    }
    random = {
      source  = "hashicorp/random"
      version = "3.6.3"
    }
  }
  # backend "azurerm" {
  #   resource_group_name  = "dev-rg"
  #   storage_account_name = "devstrg001"
  #   container_name       = "storage-blob"
  #   key                  = "dev.terraform.tfstate"

  # }
}

provider "azurerm" {
  subscription_id = "9eb6dd3b-7d3d-4d3a-82fa-3747ca6f588e"
  features {}
}


resource "azurerm_resource_group" "rgs" {
  name     = "dev-rg"
  location = "centralindia"
}

resource "azurerm_storage_account" "strg" {
  name                     = "devstrg001"
  location                 = azurerm_resource_group.rgs.location
  resource_group_name      = azurerm_resource_group.rgs.name
  account_replication_type = "LRS"
  account_tier             = "Standard"
}
output "azurerm_storage_account" {
  value = azurerm_storage_account.strg.id

}

resource "azurerm_storage_container" "blob" {
  count = 5
  name                  = "storage-blob-${count.index}"
  storage_account_id    = azurerm_storage_account.strg.id
  container_access_type = "private"
}

resource "azurerm_storage_container" "blob" {
  count = 5
  name                  = "storage-blob-${count.index}"
  storage_account_id    = azurerm_storage_account.strg.id
  container_access_type = "private"
}