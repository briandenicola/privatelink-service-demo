variable "region" {
  description = "Region to deploy in Azure"
  default     = "southcentralus"
}

variable "deploy_bastion" {
  description = "Deploy a bastion host"
  default     = false
}

variable "app_name" {
  description = "The root name for this application deployment"
}

variable "firewall_policy_id" {
  description = "Azure Resource Id of the firweall policy to be used by the application stamp"
}

variable tags {
  description = "Tags to be applied to all resources"
}

variable "vm_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
}

variable "core_subscription" {
  description = "Core Subscription"
}