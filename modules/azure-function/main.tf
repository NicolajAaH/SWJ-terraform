terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "azurerm_storage_account" "storage-function" {
  name                     = "jobboardstorage"
  resource_group_name      = var.resource_group_name
  location                 = var.resource_group_location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_service_plan" "service-plan" {
  name                = "service-plan-job"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  os_type             = "Linux"
  sku_name            = "S1"
}

resource "azurerm_linux_function_app" "notification" {
  name                       = var.function_name
  location                   = var.resource_group_location
  resource_group_name        = var.resource_group_name
  service_plan_id            = azurerm_service_plan.service-plan.id
  storage_account_name       = azurerm_storage_account.storage-function.name
  storage_account_access_key = azurerm_storage_account.storage-function.primary_access_key
  app_settings = {
    "FUNCTIONS_WORKER_RUNTIME" = "node"
  }
  site_config {
  }
}

#resource "azurerm_function_app_zip_deployments" "notification-deployment" {
#  name                      = "notification-function-app-zip-deployment"
#  function_app_id           = azurerm_function_app.example.id
#  deployment_source         = "github"
#  github_repository         = "NicolajAaH/SWJ-notification"
#  github_branch             = "main"
#}
