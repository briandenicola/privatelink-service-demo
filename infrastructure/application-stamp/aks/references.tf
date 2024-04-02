data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

data "azurerm_kubernetes_service_versions" "current" {
  location = data.azurerm_resource_group.this.location
}