variable "vm_name" {
  description = "The name of the jumpbox host"
}

variable "resource_group_name" {
  description = "The name of the resource group where the jumpbox host will be deployed"
}

variable "vm_subnet_id" {
  description = "The Azure vnet id where the jumpbox host will be deployed"
}

variable "vm_sku" {
  description = "The value for the VM SKU"
  default     = "Standard_B1ms" 
}

variable "default_admin_username" {
  description = "The default admin username for the jumpbox"
  default     = "manager"
}

variable "ssh_key_path" {
  description = "The default path to the public SSH key"
  default = "~/.ssh/id_rsa.pub"
}