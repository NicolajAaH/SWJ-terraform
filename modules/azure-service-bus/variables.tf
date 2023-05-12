variable "resource_group_name" {
  type        = string
  default = "jobboards-rg"
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  default = "westeurope"
  description = "The location of the resource group."
}

variable "service_bus_name" {
  type        = string
  description = "The name of the Azure Service Bus namespace."
}

variable "service_bus_sku" {
  type        = string
  description = "The SKU of the Azure Service Bus namespace."
  default     = "Standard"
}

variable "queue_name" {
  type        = string
  description = "The name of the Azure Service Bus queue."
}

variable "subnet_id" {
  description = "The ID of the subnet."
}