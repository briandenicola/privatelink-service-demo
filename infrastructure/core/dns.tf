
resource "azurerm_private_dns_zone" "core_privatelink_azurecr_io" {
    name                = "privatelink.azurecr.io"
    resource_group_name = azurerm_resource_group.this.name
    provider            = azurerm.core
}