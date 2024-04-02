resource "azurerm_private_dns_zone" "aks_private_zone" {
  name                = "privatelink.${local.location}.azmk8s.io"
  resource_group_name = data.azurerm_resource_group.this.name
}

resource "azurerm_private_dns_zone_virtual_network_link" "aks_private_zone" {
  name                  = "${var.aks_name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.aks_private_zone.name
  resource_group_name   = data.azurerm_resource_group.this.name
  virtual_network_id    = var.aks_vnet_id
}
