module "aks" {
  source                     = "./aks"
  aks_name                   = local.aks_name
  kubernetes_version         = var.kubernetes_version
  istio_version              = var.istio_version
  resource_group_name        = azurerm_resource_group.this.name
  aks_vnet_id                = azurerm_virtual_network.this.id
  aks_subnet_id              = azurerm_subnet.nodes.id
  aks_mgmt_subnet_id         = azurerm_subnet.api.id
  acr_id                     = azurerm_container_registry.this.id
  log_analytics_workspace_id = azurerm_log_analytics_workspace.this.id
  node_sku                   = var.node_sku
  node_count                 = var.node_count
  deploy_flux                = var.deploy_flux
}

module "bastion" {
  count               = var.deploy_bastion ? 1 : 0
  source              = "./bastion"
  bastion_name        = local.bastion_name
  resource_group_name = azurerm_resource_group.this.name
  bastion_vnet_id     = azurerm_virtual_network.this.id
}

module "cosmos" {
  count                      = var.deploy_cosmos_db ? 1 : 0
  source                     = "./cosmos"
  cosmosdb_name              = local.cosmosdb_name
  resource_group_name        = azurerm_resource_group.this.name
  private_endpoint_subnet_id = azurerm_subnet.private-endpoints.id
  virtual_network_id         = azurerm_virtual_network.this.id
}

module "eventhub" {
  count                      = var.deploy_event_hub ? 1 : 0
  source                     = "./eventhub"
  eventhub_namespace_name    = local.eventhub_namespace_name
  resource_group_name        = azurerm_resource_group.this.name
  private_endpoint_subnet_id = azurerm_subnet.private-endpoints.id
  virtual_network_id         = azurerm_virtual_network.this.id
}

module "jumpbox" {
  count               = var.deploy_jumpbox ? 1 : 0
  source              = "./jumpbox"
  resource_group_name = azurerm_resource_group.this.name
  vm_subnet_id        = azurerm_subnet.compute.id
  vm_name             = local.vm_name
}
