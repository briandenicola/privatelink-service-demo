data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "this" {
  name = var.aks_cluster.resource_group_name
}

data "azurerm_kubernetes_service_versions" "current" {
  location = data.azurerm_resource_group.this.location
}

resource "tls_private_key" "rsa" {
  algorithm = "RSA"
  rsa_bits  = 4096
}