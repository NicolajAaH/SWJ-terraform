provider "azurerm" {
  features {}
}

resource "azurerm_servicebus_namespace" "service_bus" {
  name                = var.service_bus_name
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  sku                 = var.service_bus_sku
  
}


resource "azurerm_servicebus_topic" "service_bus_topic" {
  name         = var.queue_name
  namespace_id = azurerm_servicebus_namespace.service_bus.id

  enable_partitioning = true
}

output "service_bus_connection" {
  value = azurerm_servicebus_namespace.service_bus.default_primary_connection_string
}

output "queue_name" {
  value = azurerm_servicebus_topic.service_bus_topic.name
}
