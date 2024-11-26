variable "eventhub_namespace" {
  type = object({
    name                = string
    location            = string
    resource_group_name = string
    vnet = object({
      id = string
      private_endpoint = object({
        subnet_id = string
      })
    })
  })
}