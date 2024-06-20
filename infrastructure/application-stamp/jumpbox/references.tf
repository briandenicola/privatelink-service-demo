data "azurerm_client_config" "current" {}
data "azurerm_subscription" "current" {}

data "azurerm_resource_group" "this" {
  name = var.resource_group_name
}

resource "random_password" "password" {
  length  = 25
  special = true
}