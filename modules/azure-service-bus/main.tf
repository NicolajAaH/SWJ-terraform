terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

resource "azurerm_servicebus_namespace" "service_bus" {
  name                = var.service_bus_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.service_bus_sku
  
}

resource "azurerm_servicebus_namespace_network_rule_set" "service_bus_network_rule_set" {
  namespace_id = azurerm_servicebus_namespace.service_bus.id

  network_rules {
    subnet_id                            = var.subnet_id
    ignore_missing_vnet_service_endpoint = false
  }
}


resource "azurerm_servicebus_topic" "service_bus_topic" {
  name         = var.queue_name
  namespace_id = azurerm_servicebus_namespace.service_bus.id

  enable_partitioning = true
}

output "queue_name" {
  value = azurerm_servicebus_topic.service_bus_topic.name
}
