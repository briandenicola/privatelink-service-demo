resource "azurerm_container_registry" "this" {
  name                     = local.acr_account_name
  resource_group_name      = azurerm_resource_group.this.name
  location                 = azurerm_resource_group.this.location
  sku                      = "Premium"
  admin_enabled            = false
  data_endpoint_enabled    = true 

  network_rule_set {
    default_action = "Deny"
  }
}

resource "azurerm_private_endpoint" "acr_account" {
  name                = "${local.acr_account_name}-endpoint"
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  subnet_id           = azurerm_subnet.private-endpoints.id

  private_service_connection {
    name                           = "${local.acr_account_name}-endpoint"
    private_connection_resource_id = azurerm_container_registry.this.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = azurerm_private_dns_zone.privatelink_azurecr_io.name
    private_dns_zone_ids = [azurerm_private_dns_zone.privatelink_azurecr_io.id]
  }
}

resource "azurerm_private_endpoint" "acr_account_core" {
  name                = "${local.acr_account_name}-core-endpoint"
  resource_group_name = var.core_private_endpoint_rg_name
  location            = azurerm_resource_group.this.location
  subnet_id           = data.azurerm_subnet.core_private-endpoints.id
  provider            = azurerm.core
  
  private_service_connection {
    name                           = "${local.acr_account_name}-core-endpoint"
    private_connection_resource_id = azurerm_container_registry.this.id
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = data.azurerm_private_dns_zone.core_privatelink_azurecr_io.name
    private_dns_zone_ids = [data.azurerm_private_dns_zone.core_privatelink_azurecr_io.id]
  }
}