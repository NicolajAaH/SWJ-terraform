variable "resource_group_location" {
  default     = "westeurope"
  description = "The location of the resource group."
}

variable "resource_group_name" {
  default     = "test-rg"
  description = "The name of the resource group."
}

variable "subnet_id" {
  description = "The ID of the subnet."
}

variable "environment" {
  default     = "Development"
  description = "The environment name."
}

variable "name" {
  default     = "job-boards-aks"
  description = "The name of the AKS cluster."
}