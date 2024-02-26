variable "core_subscription_id" {
  description = "Core Subscription"
}

variable "dev_subscription_id" {
  description = "Core Subscription"
}

variable tags {
  description = "Tags to be applied to all resources"
}

variable "region" {
  description = "Region to deploy in Azure"
  default     = "southcentralus"
}

variable "app_name" {
  description = "The root name for this application deployment"
}

variable "firewall_policy_id" {
  description = "Azure Resource Id of the firweall policy to be used by the application stamp"
}

variable "node_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
  validation {
    condition     = contains(["Standard_D4ads_v5", "Standard_B4ms", "Standard_A4m_v2", "Standard_D4s_v5"], var.node_sku)
    error_message = "Valid values for var: test_variable are (Standard_D4ads_v5, Standard_B4ms, Standard_A4m_v2, Standard_D4s_v5)."
  } 
}

variable "node_count" {
  description = "The value for the VM SKU"
  default     = 1
  validation {
    condition     = contains([1, 3, 6], var.node_count)
    error_message = "Valid values for var: test_variable are (1, 3, 6)."
  } 
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