module "aks" {
  depends_on = [azurerm_container_registry_cache_rule.mcr_cache_rule]
  source     = "./aks"
  aks_cluster = {
    name                = local.aks_name
    resource_group_name = azurerm_resource_group.this.name
    location            = azurerm_resource_group.this.location
    version             = var.kubernetes_version
    istio = {
      version = var.istio_version
    }
    nodes = {
      sku   = var.node_sku
      count = var.node_count
    }
    vnet = {
      id = azurerm_virtual_network.this.id
      node_subnet = {
        id = azurerm_subnet.nodes.id
      }
      mgmt_subnet = {
        id = azurerm_subnet.api.id
      }
    }
    logs = {
      workspace_id = azurerm_log_analytics_workspace.this.id
    }
    container_registry = {
      id = azurerm_container_registry.this.id
    }
    flux = {
      enabled    = var.deploy_flux
      repository = var.flux_repository
      app_path   = var.flux_app_path
    }
  }
}

module "bastion" {
  count  = var.deploy_bastion ? 1 : 0
  source = "./bastion"
  bastion_host = {
    location            = azurerm_resource_group.this.location
    name                = local.bastion_name
    resource_group_name = azurerm_resource_group.this.name
    vnet = {
      id = azurerm_virtual_network.this.id
    }
  }
}

module "cosmos" {
  count  = var.deploy_cosmos_db ? 1 : 0
  source = "./cosmos"
  cosmos = {
    name                = local.cosmosdb_name
    resource_group_name = azurerm_resource_group.this.name
    location            = azurerm_resource_group.this.location
    vnet = {
      id = azurerm_virtual_network.this.id
      private_endpoint = {
        subnet_id = azurerm_subnet.private-endpoints.id
      }
    }
  }
}

module "eventhub" {
  count  = var.deploy_event_hub ? 1 : 0
  source = "./eventhub"
  eventhub_namespace = {
    name                = local.eventhub_namespace_name
    resource_group_name = azurerm_resource_group.this.name
    location            = azurerm_resource_group.this.location
    vnet = {
      id = azurerm_virtual_network.this.id
      private_endpoint = {
        subnet_id = azurerm_subnet.private-endpoints.id
      }
    }
  }
}

module "jumpbox" {
  count  = var.deploy_jumpbox ? 1 : 0
  source = "./jumpbox"
  vm = {
    name                = local.vm_name
    resource_group_name = azurerm_resource_group.this.name
    location            = azurerm_resource_group.this.location
    sku                 = "Standard_B1s"
    admin = {
      username     = "manager"
      ssh_key_path = "~/.ssh/id_rsa.pub"
    }
    vnet = {
      subnet_id = azurerm_subnet.compute.id
    }
  }
}
