
resource "random_id" "this" {
  byte_length = 2
}

resource "random_pet" "this" {
  length    = 1
  separator = ""
}

locals {
  resource_name    = "${random_pet.this.id}-${random_id.this.dec}"
  core_rg_name     = "${local.resource_name}_core_rg"
  app_rg_name      = "${local.resource_name}_app_rg"
  tags             = "Azure Private Link for Developers Demo"
}

module "core" {
  source               = "./core"
  region               = var.region
  app_name             = local.resource_name
  core_subscription_id = var.core_subscription
  tags                 = local.tags
}

module "application-stamp" {
  depends_on = [
    module.core
  ]
  source               = "./application-stamp"
  region               = var.region
  app_name             = local.resource_name
  core_subscription_id = var.core_subscription
  dev_subscription_id  = var.dev_subscription
  tags                 = local.tags
  firewall_policy_id   = module.core.CORE_FW_POLICY_ID
  deploy_bastion       = var.deploy_bastion
  deploy_cosmos_db     = var.deploy_cosmos_db
  deploy_event_hub     = var.deploy_event_hub
  deploy_flux          = var.deploy_flux_extension
  flux_repository      = var.flux_repository
  node_count           = var.node_count
  node_sku             = var.node_sku
}
