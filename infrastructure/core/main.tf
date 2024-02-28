resource "random_integer" "vnet_cidr" {
  min = 25
  max = 250
}

locals {
  location             = var.region
  resource_name        = var.app_name
  rg_name              = "${local.resource_name}_core_rg"
  firewall_name        = "${local.resource_name}-fw"
  acr_account_name     = "${replace(local.resource_name, "-", "")}acr"
  vnet_cidr            = cidrsubnet("10.0.0.0/8", 8, random_integer.vnet_cidr.result)
  pe_subnet_cidir      = cidrsubnet(local.vnet_cidr, 8, 1)
  compute_subnet_cidir = cidrsubnet(local.vnet_cidr, 8, 4)
}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = local.location
  provider = azurerm.core

  tags = {
    Application = var.tags
    Components  = "firewall-policies; network-core"
    DeployedOn  = timestamp()
  }
}
