variable "region" {
  description = "Region to deploy in Azure"
  default     = "southcentralus"
}

variable "firewall_policy_name" {
  description = "Name of the fireall policy to be used"
}

variable "firewall_policy_rg_name" {
  description = "Firewall Policy Resource Group name"
}

variable "core_subscription" {
  description = "Core Subscription"
}

variable "core_private_endpoint_rg_name" {
  description = "The Resource Group name where the private endpoint should in created the Core network"
}

variable "core_private_endpoint_virutalnetwork_rg_name" {
  description = "The Resource Group name of the virtual network where the private endpoint for ACR should be placed in the Core network"
}

variable "core_private_endpoint_virutalnetwork_name" {
  description = "The Virtual Network name where the private endpoint for ACR should be placed in the Core network"
}

variable "core_dns_rg_name" {
  description = "The Resource Group name of the DNS zone privatelink.azurecr.io in the Core Network"
}

