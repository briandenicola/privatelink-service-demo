variable "azure_rbac_group_object_id" {
  description = "GUID of the AKS admin Group"
  default     = "15390134-7115-49f3-8375-da9f6f608dce"
}

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