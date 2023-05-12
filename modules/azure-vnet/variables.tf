variable "resource_group_location" {
  default = "westeurope"
  description = "The location of the resource group."
}

variable "resource_group_name" {
  default = "jobboards-rg"
  description = "The name of the resource group."
}

variable "vnet_name" {
  description = "The name of the Azure VNet."
}