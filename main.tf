terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Define provider
provider "azurerm" {
  features {}
}

module "azure-resource-group" {
  source                  = "./modules/azure-resource-group"
  resource_group_location = var.resource_group_location
}

module "azure-vnet" {
  source                  = "./modules/azure-vnet"
  depends_on              = [module.azure-resource-group]
  resource_group_name     = module.azure-resource-group.resource_group_name
  resource_group_location = var.resource_group_location
  vnet_name               = "jobboards-vnet"
}

module "azure-subnet" {
  source                  = "./modules/azure-subnet"
  depends_on              = [module.azure-vnet]
  resource_group_name     = module.azure-resource-group.resource_group_name
  resource_group_location = var.resource_group_location
  vnet_name               = module.azure-vnet.vnet_name
}

module "azure-kubernetes-service" {
  source                  = "./modules/azure-kubernetes-service"
  depends_on              = [module.azure-subnet]
  resource_group_name     = module.azure-resource-group.resource_group_name
  resource_group_location = var.resource_group_location
  subnet_id               = module.azure-subnet.subnet_id
  environment             = "Development"
}

module "azure-service-bus" {
  source     = "./modules/azure-service-bus"
  depends_on = [module.azure-subnet]

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  service_bus_name        = "jobboards-service-bus"
  service_bus_sku         = "Premium"
  queue_name              = "NEW_JOB"
  subnet_id               = module.azure-subnet.subnet_id
}

module "azure-function" {
  source     = "./modules/azure-function"
  depends_on = [module.azure-subnet]

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  function_name           = "notification-jobboards"
}

module "azure-postgres" {
  source     = "./modules/azure-postgres"
  depends_on = [module.azure-subnet]

  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
  subnet_id               = module.azure-subnet.subnet_id

}

module "azure-cosmos-mongodb" {
  source                  = "./modules/azure-cosmos-mongodb"
  depends_on              = [module.azure-subnet]
  resource_group_name     = var.resource_group_name
  resource_group_location = var.resource_group_location
}
