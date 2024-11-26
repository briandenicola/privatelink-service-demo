
resource "azurerm_eventhub_namespace" "this" {
  name                     = var.eventhub_namespace.name
  resource_group_name      = var.eventhub_namespace.resource_group_name
  location                 = var.eventhub_namespace.location
  sku                      = "Standard"
  maximum_throughput_units = 5
  auto_inflate_enabled     = true
}

resource "azurerm_eventhub" "this" {
  depends_on = [
    azurerm_eventhub_namespace.this
  ]

  name                = "events"
  namespace_name      = azurerm_eventhub_namespace.this.name
  resource_group_name = var.eventhub_namespace.resource_group_name
  partition_count     = 15
  message_retention   = 7
}

