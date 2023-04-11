variable "resource_group_location" {
  default = "westeurope"
  description = "The location of the resource group."
}

variable "resource_group_name" {
  default = "job-boards-rg"
  description = "The name of the resource group."
}

variable "service_bus_connection" {
  description = "The connection string of the Azure Service Bus namespace."
}

variable "service_bus_queue_name" {
  description = "The name of the Azure Service Bus queue."
  default = "NEW_JOB"
}

variable "function_name" {
  description = "The name of the Azure Function."
}