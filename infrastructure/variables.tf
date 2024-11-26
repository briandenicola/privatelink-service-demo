variable "region" {
  description = "Region to deploy in Azure"
}

variable "tags" {
  description = "Tags to apply for this resource"
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

variable "deploy_flux_extension" {
  description = "Deploy Flux Extension"
}

variable "flux_repository" {
  description = "The repository for the Flux extension GitOps configuration"
  default     = ""
}

variable "node_count" {
  description = "The value for the VM SKU"
  default     = 1
}

variable "node_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
}

variable "istio_version" {
  description = "The version of the managed Azure Service Mesh to deploy"
  default     = "asm-1.23"
}

variable "kubernetes_version" {
  description = "The version of Kubernetes to deploy"
  default     = "1.30"
}