resource "azapi_resource" "aks" {
  type      = "Microsoft.ContainerService/managedClusters@2024-06-02-preview"
  name      = local.aks_name
  location  = data.azurerm_resource_group.this.location
  parent_id = data.azurerm_resource_group.this.id

  identity {
    type         = "UserAssigned"
    identity_ids = [azurerm_user_assigned_identity.aks_identity.id]
  }

  body = jsonencode({
    sku = {
      name = "Base"
      tier = "Standard"
    }
    properties = {
      kubernetesVersion    = local.kubernetes_version
      dnsPrefix            = local.aks_name
      enableRBAC           = true
      disableLocalAccounts = true
      nodeResourceGroup    = "${local.aks_name}_nodes_rg"

      networkProfile = {
        networkPlugin     = "azure"
        networkPluginMode = "overlay"
        loadBalancerSku   = "standard"
        networkPolicy     = "cilium"
        networkDataplane  = "cilium"
        outboundType      = "none"
        serviceCidr       = "100.${random_integer.services_cidr.id}.0.0/16"
        dnsServiceIP      = "100.${random_integer.services_cidr.id}.0.10"
        podCidr           = "100.${random_integer.pod_cidr.id}.0.0/16"
        advancedNetworking = {
            observability = {
                enabled = true
            }
        }
      }

      bootstrapProfile = {
        artifactSource = "Cache"
      }

      agentPoolProfiles = [{
        name              = "system"
        mode              = "System"
        count             = var.node_count
        vmSize            = var.node_sku
        osDiskSizeGB      = 127
        vnetSubnetID      = var.aks_subnet_id
        osType            = "Linux"
        osSKU             = "AzureLinux"
        type              = "VirtualMachineScaleSets"
        maxPods           = 110
        enableAutoScaling = false
        upgradeSettings = {
          maxSurge = "33%"
        }
      }]

      addonProfiles = {
        omsagent = {
          enabled = true
          config = {
            logAnalyticsWorkspaceResourceID = var.log_analytics_workspace_id
          }
        }
        azurePolicy = {
          enabled = true
        }
        azureKeyvaultSecretsProvider = {
          enabled = true
        }
      }

      autoUpgradeProfile = {
        nodeOSUpgradeChannel = "NodeImage"
        upgradeChannel       = "patch"
      }

      metricsProfile = {
        costAnalysis = {
          enabled = true
        }
      }

      azureMonitorProfile = {
        appMonitoring = {
          autoInstrumentation  = {
            enabled     = true
          }
          openTelemetryLogs = {
            enabled = true
          }
          openTelemetryMetrics = {
            enabled = true
          }
        }
        containerInsights = {
            enabled                         = true
            logAnalyticsWorkspaceResourceId = var.log_analytics_workspace_id
        }        
        metrics = {
          enabled   = true
        }
      }

      securityProfile = {
        defender = {
          logAnalyticsWorkspaceResourceId = var.log_analytics_workspace_id
          securityMonitoring = {
            enabled = true
          }
        }
        imageCleaner = {
          enabled       = true
          intervalHours = 48
        }
        workloadIdentity = {
          enabled = true
        }
      }

      workloadAutoScalerProfile = {
        keda = {
          enabled = true
        }
      }

      oidcIssuerProfile = {
        enabled = true
      }

      apiServerAccessProfile = {
        enablePrivateCluster           = true
        privateDNSZone                 = azurerm_private_dns_zone.aks_private_zone.id
        enablePrivateClusterPublicFQDN = false
        disableRunCommand              = true
        enableVnetIntegration          = true
        subnetId                       = var.aks_mgmt_subnet_id
      }

      serviceMeshProfile = {
        istio = {
          components = {
            ingressGateways = [
              {
                enabled = true
                mode    = "Internal"
              }
            ]
          }
        }
        mode = "Istio"
      }
    }
  })
}

resource "azurerm_monitor_diagnostic_setting" "aks" {
  name                       = "diag"
  target_resource_id         = azapi_resource.aks.id
  log_analytics_workspace_id = var.log_analytics_workspace_id

  enabled_log {
    category = "kube-apiserver"
  }

  enabled_log {
    category = "kube-audit"
  }

  enabled_log {
    category = "kube-audit-admin"
  }

  enabled_log {
    category = "kube-controller-manager"
  }

  enabled_log {
    category = "kube-scheduler"
  }

  enabled_log {
    category = "cluster-autoscaler"
  }

  enabled_log {
    category = "guard"
  }

  metric {
    category = "AllMetrics"
  }
}
