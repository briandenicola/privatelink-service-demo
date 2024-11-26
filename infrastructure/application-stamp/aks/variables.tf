variable "aks_cluster" {
  type = object({
    name     = string
    location = string
    resource_group = object({
      name = string
      id   = string
    })
    version = string
    istio = object({
      version = string
    })
    nodes = object({
      sku   = string
      count = number
    })
    vnet = object({
      id = string
      node_subnet = object({
        id = string
      })
      mgmt_subnet = object({
        id = string
      })
    })
    logs = object({
      workspace_id = string
    })
    container_registry = object({
      id = string
    })
    flux = object({
      enabled    = bool
      repository = string
      app_path   = string
    })
  })
}
