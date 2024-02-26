variable "region" {
  description = "Region to deploy in Azure"
  default     = "southcentralus"
}

variable "app_name" {
  description = "The root name for this application deployment"
}

variable tags {
  description = "Tags to be applied to all resources"
}

variable "firewall_policy_id" {
  description = "Azure Resource Id of the firweall policy to be used by the application stamp"
}

variable "node_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_D4ads_v5"
  validation {
    condition     = contains(["item1", "item2", "item3"], var.test_variable)
    error_message = "Valid values for var: test_variable are (item1, item2, item3)."
  } 
}

variable "node_count" {
  description = "The value for the VM SKU"
  default     = 1
  validation {
    condition     = contains(["item1", "item2", "item3"], var.test_variable)
    error_message = "Valid values for var: test_variable are (item1, item2, item3)."
  } 
}

variable "core_subscription" {
  description = "Core Subscription"
}

variable "app_subscription" {
  description = "Core Subscription"
}

variable "deploy_bastion" {
  description = "Deploy a bastion host"
  default     = false
}