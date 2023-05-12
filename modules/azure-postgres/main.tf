terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "azurerm_postgresql_server" "postgresserver" {
  name                = "jobboards-postgres"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name

  sku_name   = "GP_Gen5_4"
  version    = "11"
  storage_mb = 640000

  backup_retention_days        = 7
  geo_redundant_backup_enabled = true
  auto_grow_enabled            = true

  public_network_access_enabled    = false
  ssl_enforcement_enabled          = true
  ssl_minimal_tls_version_enforced = "TLS1_2"
}

resource "azurerm_postgresql_virtual_network_rule" "postgresnetworkrule" {
  name                                 = "postgresql-vnet-rule"
  resource_group_name                  = var.resource_group_name
  server_name                          = azurerm_postgresql_server.postgresserver.name
  subnet_id                            = var.subnet_id
  ignore_missing_vnet_service_endpoint = true
}