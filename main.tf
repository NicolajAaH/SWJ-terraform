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

module "azure-resource-group" {
  source = "./modules/azure-resource-group"
  resource_group_location = var.resource_group_location
}

module "azure-kubernetes-service" {
  source = "./modules/azure-kubernetes-service"
  resource_group_name = module.azure-resource-group.resource_group_name
  resource_group_location = var.resource_group_location
}