terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "=3.0.0"
    }
  }
}

# Create AKS cluster
resource "azurerm_kubernetes_cluster" "aks" {
  name                = "test-aks"
  location            = var.resource_group_location
  resource_group_name = var.resource_group_name
  dns_prefix          = "testsaks"
  auto_scaler_profile {
    scale_down_utilization_threshold = 0.8
  }
  default_node_pool {
    name       = "default"
    node_count = 1
    vm_size    = "Standard_B2s"
    vnet_subnet_id = var.subnet_id
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
  value     = azurerm_kubernetes_cluster.aks.kube_config.0.client_certificate
  sensitive = true
}

output "kube_config" {
  value = azurerm_kubernetes_cluster.aks.kube_config_raw
  sensitive = true
}
