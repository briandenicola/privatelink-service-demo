resource "azurerm_public_ip" "this" {
  name                = local.firewall_pip_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  allocation_method   = "Static"
  sku                 = "Standard" 
}

resource azurerm_firewall this {
  name                = local.firewall_name
  resource_group_name = azurerm_resource_group.this.name
  location            = azurerm_resource_group.this.location
  firewall_policy_id  = var.firewall_policy_id
  sku_tier            = "Basic"
  sku_name            = "AZFW_VNet"

  management_ip_configuration {
    name = "management"
    subnet_id = azurerm_subnet.AzureFirewallManagement.id
    public_ip_address_id = azurerm_public_ip.this.id
  }

  ip_configuration {
    name                 = "standard"
    subnet_id            = azurerm_subnet.AzureFirewall.id

  }
}

resource azurerm_monitor_diagnostic_setting this {
  name                        = "diag"
  target_resource_id          = azurerm_firewall.this.id
  log_analytics_workspace_id  = azurerm_log_analytics_workspace.this.id

  enabled_log {
    category = "AzureFirewallApplicationRule"

  }

  enabled_log {
    category = "AzureFirewallNetworkRule"

  }

  enabled_log {
    category = "AzureFirewallDnsProxy"

  }

  metric {
    category = "AllMetrics"
  }
}