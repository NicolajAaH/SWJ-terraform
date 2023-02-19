terraform {
    required_version = ">= 0.13"
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = ">= 2.0"
        }
    }
}

# Define provider
provider "azurerm" {
  features {}
}

# Create resource group
resource "azurerm_resource_group" "rg" {
  name     = "job-boards-rg"
  location = var.resource_group_location
}
