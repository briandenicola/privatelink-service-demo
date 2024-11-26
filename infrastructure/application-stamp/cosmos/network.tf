resource "azurerm_private_dns_zone" "privatelink_documents_azure_com" {
  name                = "privatelink.documents.azure.com"
  resource_group_name = var.cosmos.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_documents_azure_com" {
  name                  = "${var.cosmos.name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_documents_azure_com.name
  resource_group_name = var.cosmos.resource_group_name
  virtual_network_id    = var.cosmos.vnet.id
}

resource "azurerm_private_endpoint" "cosmos_db" {
  name                = "${var.cosmos.name}-endpoint"
  resource_group_name = var.cosmos.resource_group_name
  location            = var.cosmos.location
  subnet_id           = var.cosmos.vnet.private_endpoint.subnet_id

  private_service_connection {
    name                           = "${var.cosmos.name}-endpoint"
    private_connection_resource_id = azurerm_cosmosdb_account.this.id
    subresource_names              = ["sql"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_documents_azure_com.name
    private_dns_zone_ids = [ azurerm_private_dns_zone.privatelink_documents_azure_com.id ] 
  }
}



