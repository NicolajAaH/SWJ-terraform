variable "resource_group_name" {
  type        = string
  default     = "jobboards-rg"
  description = "The name of the resource group."
}

variable "resource_group_location" {
  type        = string
  default     = "westeurope"
  description = "The location of the resource group."
}

variable "subnet_id" {
  description = "The ID of the subnet."
}
