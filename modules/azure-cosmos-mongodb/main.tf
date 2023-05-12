terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

data "azurerm_cosmosdb_account" "cosmosdbaccount" {
  name                = "jobboards-cosmosdb-account"
  resource_group_name = var.resource_group_name
}

resource "azurerm_cosmosdb_mongo_database" "mongodb" {
  name                = "jobboards-cosmos-mongo-db"
  resource_group_name = data.azurerm_cosmosdb_account.cosmosdbaccount.resource_group_name
  account_name        = data.azurerm_cosmosdb_account.cosmosdbaccount.name
}
