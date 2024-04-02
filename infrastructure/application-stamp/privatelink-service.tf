data "azurerm_lb" "aks_ingress_lb" {
    depends_on = [ 
      module.aks
    ]
    name                = "kubernetes-internal"
    resource_group_name = module.aks.AKS_NODE_RESOURCE_GROUP
}

resource "azurerm_private_link_service" "this" {
  name                                        = "${local.aks_name}-privatelink-service"
  resource_group_name                         = azurerm_resource_group.this.name
  location                                    = azurerm_resource_group.this.location
  enable_proxy_protocol                       = false
  auto_approval_subscription_ids              = [var.core_subscription_id]
  visibility_subscription_ids                 = [var.core_subscription_id]
  load_balancer_frontend_ip_configuration_ids = [data.azurerm_lb.aks_ingress_lb.frontend_ip_configuration.0.id]

  nat_ip_configuration {
    name                       = "primary"
    private_ip_address_version = "IPv4"
    subnet_id                  = azurerm_subnet.privatelink-snat.id
    primary                    = true
  }
}
