resource "azurerm_private_dns_zone" "privatelink_servicebus_windows_net" {
  name                = "privatelink.servicebus.windows.net"
  resource_group_name = var.eventhub_namespace.resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_servicebus_windows_net" {
  name                  = "${var.eventhub_namespace.name}-link"
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
  resource_group_name   = var.eventhub_namespace.resource_group_name
  virtual_network_id    = var.eventhub_namespace.vnet.id
}

resource "azurerm_private_endpoint" "eventhub_namespace" {
  name                = "${var.eventhub_namespace.name}-endpoint"
  resource_group_name = var.eventhub_namespace.resource_group_name
  location            = var.eventhub_namespace.location
  subnet_id           = var.eventhub_namespace.vnet.private_endpoint.subnet_id

  private_service_connection {
    name                           = "${var.eventhub_namespace.name}-endpoint"
    private_connection_resource_id = azurerm_eventhub_namespace.this.id
    subresource_names              = ["namespace"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_servicebus_windows_net.name
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_servicebus_windows_net.id]
  }
}



