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

module "azure-service-bus" {
  source = "./modules/azure-service-bus"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  service_bus_name        = "job-boards-service-bus"
  service_bus_sku         = "Standard"
  queue_name              = "NEW_JOB"
}

module "azure-function" {
  source = "./modules/azure-function"

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  function_name           = "job-boards-notification-function"
  service_bus_connection  = module.azure-service-bus.service_bus_connection
  service_bus_queue_name  = module.azure-service-bus.queue_name
}