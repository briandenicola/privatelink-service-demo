resource "random_integer" "vnet_cidr" {
  min = 25
  max = 250
}

resource "random_integer" "pod_cidr" {
  min = 100
  max = 127
}

resource "random_integer" "services_cidr" {
  min = 64
  max = 99
}

locals {
  location                = var.region
  resource_name           = var.app_name
  
  rg_name                 = "${local.resource_name}_app_rg"
  aks_name                = "${local.resource_name}-aks"
  aks_node_rg_name        = "${local.resource_name}_k8s_nodes_rg"
  firewall_name           = "${local.resource_name}-fw"
  firewall_pip_name       = "${local.resource_name}-fw-pip"
  routetable_name         = "${local.resource_name}-routetable"
  cosmosdb_name           = "${local.resource_name}-db"
  eventhub_namespace_name = "${local.resource_name}-eventhub-namespace"
  bastion_name            = "${local.resource_name}-bastion"
  bastion_pip_name        = "${local.resource_name}-bastion-pip"
  kv_name                 = "${local.resource_name}-kv"
  acr_account_name        = "${replace(local.resource_name,"-","")}acr"
  
  app_path                = "./cluster-config"
  flux_repository         = "https://github.com/briandenicola/privatelink-service-demo"
  
  vnet_cidr               = cidrsubnet("10.0.0.0/8", 8, random_integer.vnet_cidr.result)
  fw_subnet_cidr          = cidrsubnet(local.vnet_cidr, 8, 0)
  pe_subnet_cidir         = cidrsubnet(local.vnet_cidr, 8, 1)
  api_subnet_cidir        = cidrsubnet(local.vnet_cidr, 8, 2)
  nodes_subnet_cidir      = cidrsubnet(local.vnet_cidr, 8, 3)
  compute_subnet_cidir    = cidrsubnet(local.vnet_cidr, 8, 4)
  pls_subnet_cidir        = cidrsubnet(local.vnet_cidr, 8, 10)
  bastion_subnet_cidir    = cidrsubnet(local.vnet_cidr, 8, 250)
}

resource "azurerm_resource_group" "this" {
  name     = local.rg_name
  location = local.location

  tags = {
    Application = var.tags
    Components  = "aks; aks-overlay;aks-vnet-injection"
    DeployedOn  = timestamp()
  }
}
