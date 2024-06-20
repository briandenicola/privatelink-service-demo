resource "azurerm_bastion_host" "this" {
  name                = var.bastion_name
  location            = data.azurerm_resource_group.this.location
  resource_group_name = data.azurerm_resource_group.this.name
  sku                 = "Developer"
  virtual_network_id  = var.bastion_vnet_id
}
