variable "region" {
  description = "Region to deploy in Azure"
  default     = "southcentralus"
}

variable "core_subscription" {
  description = "Core Subscription"
}

variable "dev_subscription" {
  description = "Developer Subscription"
}

variable "deploy_bastion" {
  description = "Deploy a bastion host"
}

variable "deploy_event_hub" {
  description = "Deploy an Event Hub namespace"
}

variable "deploy_cosmos_db" {
  description = "Deploy a Cosmos DB instance"
}

variable "node_count" {
  description = "The value for the VM SKU"
  default     = 1
}

variable "node_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
}