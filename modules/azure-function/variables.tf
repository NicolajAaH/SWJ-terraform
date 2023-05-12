variable "resource_group_location" {
  default = "westeurope"
  description = "The location of the resource group."
}

variable "resource_group_name" {
  default = "test-rg"
  description = "The name of the resource group."
}

variable "function_name" {
  description = "The name of the Azure Function."
}