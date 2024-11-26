resource "azurerm_virtual_network" "this" {
  name                = "${local.resource_name}-core-network"
  address_space       = [local.vnet_cidr]
  location            = azurerm_resource_group.this.location
  resource_group_name = azurerm_resource_group.this.name
  provider            = azurerm.core
}

resource "azurerm_subnet" "private-endpoints" {
  name                 = "private-endpoints"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [local.pe_subnet_cidir]
  provider             = azurerm.core
}

resource "azurerm_subnet" "compute" {
  name                 = "compute"
  resource_group_name  = azurerm_resource_group.this.name
  virtual_network_name = azurerm_virtual_network.this.name
  address_prefixes     = [local.compute_subnet_cidir]
  provider             = azurerm.core
}
