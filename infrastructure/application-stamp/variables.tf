variable "core_subscription_id" {
  description = "Core Subscription"
}

variable "dev_subscription_id" {
  description = "Developer Subscription"
}

variable tags {
  description = "Tags to be applied to all resources"
}

variable "region" {
  description = "Region to deploy in Azure"
}

variable "app_name" {
  description = "The root name for this application deployment"
}

variable "istio_version" {
  description = "The version of the managed Azure Service Mesh to deploy"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to deploy"
}

variable "node_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
}

variable "node_count" {
  description = "The value for the VM SKU"
  default     = 1
}

variable "deploy_bastion" {
  description = "Deploy a bastion host"
  default     = false
}

variable "deploy_event_hub" {
  description = "Deploy an Event Hub namespace"
  default     = false
}

variable "deploy_cosmos_db" {
  description = "Deploy a Cosmos DB instance"
  default     = false
}

variable "deploy_flux" {
  description = "Deploy Flux Extension"
  default     = false
}

variable "deploy_jumpbox" {
  description = "Deploy Jumpbox"
  default     = true
}

variable "flux_repository" {
  description = "The repository for the Flux extension GitOps configuration"
  default     = "https://github.com/samples/flux-get-started"
}
