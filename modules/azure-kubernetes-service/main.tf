terraform {
    required_version = ">= 0.13"
    required_providers {
        azurerm = {
        source  = "hashicorp/azurerm"
        version = ">= 2.0"
        }
    }
}

# Define provider
provider "azurerm" {
  features {}
}

# Create AKS cluster
resource "azurerm_kubernetes_cluster" "jobboardsaks" {
  name                = "job-boards-aks"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "jobboardsaks"
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
  }

  identity {
    type = "SystemAssigned"
  }

  tags = {
    Environment = "Development"
  }
}

# Export output
output "client_certificate" {
  value     = azurerm_kubernetes_cluster.jobboardsaks.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.jobboardsaks.kube_config_raw
  sensitive = true
}
