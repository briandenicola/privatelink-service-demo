resource "azurerm_kubernetes_cluster_extension" "flux" {
  depends_on = [
    #azurerm_kubernetes_cluster.this
    azapi_resource.aks
  ]
  
  count          = var.aks_cluster.flux.enabled ? 1 : 0
  name           = "flux"
  cluster_id     = azapi_resource.aks.id #azurerm_kubernetes_cluster.this.id
  extension_type = "microsoft.flux"
}

resource "azurerm_kubernetes_flux_configuration" "flux_config" {
  depends_on = [
    azurerm_kubernetes_cluster_extension.flux
  ]

  count       = var.aks_cluster.flux.enabled ? 1 : 0
  name        = "aks-flux-extension"
  cluster_id  = azapi_resource.aks.id #azurerm_kubernetes_cluster.this.id
  namespace   = "flux-system"
  scope       = "cluster"

  git_repository {
    url                      = var.aks_cluster.flux.repository
    reference_type           = "branch"
    reference_value          = "main"
    timeout_in_seconds       = 600
    sync_interval_in_seconds = 30
  }

  kustomizations {
    name = "cluster-config"
    path = var.aks_cluster.flux.app_path

    timeout_in_seconds         = 600
    sync_interval_in_seconds   = 120
    retry_interval_in_seconds  = 300
    garbage_collection_enabled = true
  }
}
