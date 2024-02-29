resource "azurerm_private_endpoint" "aks_ingress_core" {
  depends_on = [
    module.core,
    module.application-stamp
  ]
  
  name                = "${local.aks_name}-ingress-core-endpoint"
  resource_group_name = local.core_rg_name
  location            = var.region
  subnet_id           = module.core.CORE_VNET_PE_SUBNET_ID
  provider            = azurerm.core
  
  private_service_connection {
    name                           ="${local.aks_name}-ingress-core-endpoint"
    private_connection_resource_id = module.application-stamp.PRIVATE_LINK_SERVICE_ID
    is_manual_connection           = false
  }
}

resource "azurerm_private_endpoint" "acr_account_core" {
  depends_on = [ 
    module.core,
    module.application-stamp
  ]

  name                = "${local.acr_account_name}-core-endpoint"
  resource_group_name = local.core_rg_name
  location            = var.region
  subnet_id           = module.core.CORE_VNET_PE_SUBNET_ID
  provider            = azurerm.core
  
  private_service_connection {
    name                           = "${local.acr_account_name}-core-endpoint"
    private_connection_resource_id = module.application-stamp.ACR_ID
    subresource_names              = ["registry"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name                 = module.core.CORE_ACR_DNS_ZONE_NAME
    private_dns_zone_ids = [module.core.CORE_ACR_DNS_ZONE_ID]
  }
}