data "azurerm_subnet" "core_private-endpoints" {
    name                 = "private-endpoints"
    virtual_network_name = var.core_private_endpoint_virutalnetwork_name
    resource_group_name  = var.core_private_endpoint_virutalnetwork_rg_name
    provider             = azurerm.core
}

data "azurerm_private_dns_zone" "core_privatelink_azurecr_io" {
    name                = "privatelink.azurecr.io"
    resource_group_name = var.core_dns_rg_name
    provider            = azurerm.core
}